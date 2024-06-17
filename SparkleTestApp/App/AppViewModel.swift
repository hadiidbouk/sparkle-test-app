//
//  AppViewModel.swift
//  SparkleTestApp
//
//  Created by Hadi Dbouk on 17/06/2024.
//

import Foundation

@Observable
final class AppViewModel {
	var commandLineToolMessage = "-"

	func viewWillAppear() {
		do {
			commandLineToolMessage = try runCommandLineTool()
		} catch {
			commandLineToolMessage = error.localizedDescription
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
}
