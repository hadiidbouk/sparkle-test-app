//
//  AppViewModel.swift
//  SparkleTestApp
//
//  Created by Hadi Dbouk on 17/06/2024.
//

import XPCService
import Foundation
import SecurityFoundation

@Observable
final class AppViewModel {
	private let connection = NSXPCConnection(serviceName: "com.hadiidbouk.xpcservice")

	var commandLineToolMessage = "-"
	var firstNumber = "1" { didSet { callXPCService() } }
	var secondNumber = "2" { didSet { callXPCService() } }
	var xpcServiceResult = "-"

	init() {
	}

	func viewWillAppear() async {
		Task {
			connection.remoteObjectInterface = NSXPCInterface(with: XPCServiceProtocol.self)
			connection.resume()

			do {
				commandLineToolMessage = try runCommandLineTool()
				callXPCService()
			} catch {
				commandLineToolMessage = error.localizedDescription
			}
		}
	}
}

private extension AppViewModel {
	func runCommandLineTool() throws -> String {
		let executablesDirURL = Bundle.main.executableURL?.deletingLastPathComponent()
		guard let commandURL = executablesDirURL?.appendingPathComponent("CommandLineTool") else {
			return "CMD line tool not found"
		}
		let process = Process()
		process.executableURL = commandURL
		process.arguments = ["arg1", "arg2"]

		let pipe = Pipe()
		process.standardOutput = pipe

		try process.run()
		process.waitUntilExit()

		let data = pipe.fileHandleForReading.readDataToEndOfFile()
		let output = String(data: data, encoding: .utf8)

		return output ?? "Nil"
	}

	func callXPCService() {
		guard
			let firstNumberInt = Int(firstNumber),
			let secondNumberInt = Int(secondNumber)
		else {
			xpcServiceResult = "N/A"
			return
		}
		if let service = connection.remoteObjectProxyWithErrorHandler({ print("Received error:", $0) }) as? XPCServiceProtocol {
			service.performCalculation(firstNumber: firstNumberInt, secondNumber: secondNumberInt) { [weak self] result in
				self?.xpcServiceResult = "\(result)"
			}
		}
	}
}
