//
//  AppDelegate.swift
//  SparkleTestApp
//
//  Created by Hadi Dbouk on 17/06/2024.
//

import AppKit
import SwiftUI

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
	}
}
