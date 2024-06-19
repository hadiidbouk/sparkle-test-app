//
//  XPCServiceProtocol.swift
//  XPCService
//
//  Created by Hadi Dbouk on 18/06/2024.
//

import Foundation

@objc public protocol XPCServiceProtocol {
    func performCalculation(firstNumber: Int, secondNumber: Int, with reply: @escaping (Int) -> Void)
}
