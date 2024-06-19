//
//  ExamplePlugin.swift
//  SparkleTestApp
//
//  Created by Hadi Dbouk on 19/06/2024.
//

import Foundation
import SharedFramework

final class ExamplePlugin: Plugin {
	var name: String = "ExamplePlugin"
	
	func saySomething() -> String {
		return "Something! - From Example Plugin"
	}
}
