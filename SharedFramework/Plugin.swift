//
//  Plugin.swift
//  SparkleTestApp
//
//  Created by Hadi Dbouk on 19/06/2024.
//

import Foundation

public protocol Plugin {
	var name: String { get }
	func saySomething() -> String
	init()
}
