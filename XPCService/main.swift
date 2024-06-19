//
//  main.swift
//  XPCService
//
//  Created by Hadi Dbouk on 18/06/2024.
//

import Foundation
import SharedFramework

class ServiceDelegate: NSObject, NSXPCListenerDelegate {
    
    func listener(_ listener: NSXPCListener, shouldAcceptNewConnection newConnection: NSXPCConnection) -> Bool {
        newConnection.exportedInterface = NSXPCInterface(with: XPCServiceProtocol.self)
        
        let exportedObject = XPCService()
        newConnection.exportedObject = exportedObject
        newConnection.resume()
        
        return true
    }
}

let delegate = ServiceDelegate()
let listener = NSXPCListener.service()
listener.delegate = delegate
listener.resume()
