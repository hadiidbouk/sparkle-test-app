//
//  XPCService.swift
//  XPCService
//
//  Created by Hadi Dbouk on 18/06/2024.
//

import Foundation
import SharedFramework

class XPCService: NSObject, XPCServiceProtocol {
    @objc func performCalculation(firstNumber: Int, secondNumber: Int, with reply: @escaping (Int) -> Void) {
        let response = firstNumber + secondNumber
        reply(response)
    }
}
