//
//  MainMenu.swift
//  Immi-macOS
//
//  Created by Hadi Dbouk on 28/07/2022.
//  Copyright © 2022 Fueled. All rights reserved.
//

import AppKit
import Sparkle

final class MainMenu: NSMenu {
	private let updaterController = SPUStandardUpdaterController(
		startingUpdater: true,
		updaterDelegate: nil,
		userDriverDelegate: nil
	)

	init() {
		super.init(title: "")

		let menuItem = NSMenuItem()
		addItem(menuItem)

		let appMenu = NSMenu()
		menuItem.submenu = appMenu

		let productName = Bundle.main.infoDictionary?["CFBundleName"] as? String ?? ""

		let aboutMenuItem = NSMenuItem(
			title: "About \(productName)",
			action: #selector(openAboutPanel),
			keyEquivalent: ""
		)
		aboutMenuItem.target = self
		appMenu.addItem(aboutMenuItem)

		let checkForUpdatesMenuItem = NSMenuItem()
		checkForUpdatesMenuItem.title = "Check For Updates"
		checkForUpdatesMenuItem.target = updaterController
		checkForUpdatesMenuItem.action = #selector(updaterController.checkForUpdates)

		appMenu.addItem(checkForUpdatesMenuItem)

		appMenu.addItem(NSMenuItem.separator())

		appMenu.addItem(.separator())

		appMenu.addItem(
			withTitle: "Hide",
			action: #selector(NSApplication.hide),
			keyEquivalent: "h"
		)
		appMenu.addItem({ () -> NSMenuItem in
			let menuItem = NSMenuItem(
				title: "Hide Others",
				action: #selector(NSApplication.hideOtherApplications),
				keyEquivalent: "h"
			)
			menuItem.keyEquivalentModifierMask = [.command, .option]
			return menuItem
		}())

		appMenu.addItem(NSMenuItem.separator())

		appMenu.addItem(
			withTitle: "Quit",
			action: #selector(NSApplication.terminate),
			keyEquivalent: "q"
		)
	}

	required init(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	@objc private func openAboutPanel() {
		NSApp.orderFrontStandardAboutPanel(nil)
	}
}
