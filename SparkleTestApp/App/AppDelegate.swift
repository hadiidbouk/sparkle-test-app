//
//  AppDelegate.swift
//  SparkleTestApp
//
//  Created by Hadi Dbouk on 17/06/2024.
//

import AppKit
import OSLog
import SharedFramework
import SwiftUI

let logger = Logger(subsystem: "com.hadiidbouk.SparkleTestApp", category: "App")

@MainActor
final class AppDelegate: NSObject, NSApplicationDelegate {
	private var window: NSWindow!
	private let viewModel = AppViewModel()

	func applicationDidFinishLaunching(_ notification: Notification) {
		NSApp.mainMenu = MainMenu()

		let window = NSWindow(
			contentRect: .zero,
			styleMask: [.titled, .closable, .miniaturizable, .resizable],
			backing: .buffered,
			defer: false
		)
		window.setFrameAutosaveName("com.hadiidbouk.SparkleTestApp.mainWindow")
		window.title = "Sparkle Test App"
		window.center()
		window.contentView = NSHostingView(rootView: AppView(viewModel: viewModel))
		window.makeKeyAndOrderFront(self)

		self.window = window

		loadPlugin()
	}
}

extension AppDelegate {
	func loadPlugin() {
		let pluginPath = Bundle.main.bundlePath + "/Contents/Plugins/ExamplePlugin.bundle"

		guard let bundle = Bundle(path: pluginPath) else {
			logger.error("Failed to load bundle at path: \(pluginPath)")
			return
		}
		bundle.load()

		guard let pluginType = bundle.principalClass as? Plugin.Type else {
			logger.error("Failed to get principal class")
			return
		}
		let plugin = pluginType.init()
		logger.debug("Loaded plugin: \(plugin.name)")
		let pluginMessage = plugin.saySomething()
		viewModel.pluginMessage = pluginMessage
	}
}
