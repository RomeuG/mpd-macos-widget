//
//  MPDClient.swift
//  mpd-whatsplaing-extension
//
//  Created by Romeu Gomes on 17/09/2019.
//  Copyright © 2019 Romeu Vieira da Silva Gomes. All rights reserved.
//

import Foundation
import SwiftSocket

class MPDClient {
    private let client: TCPClient
    
    private let TIMEOUT: Int = 4
    private let DATALEN: Int = 1024
    
    init(ipAddress: String, port: Int) {
        self.client = TCPClient(address: ipAddress, port: Int32(port))
    }
    
    public func connect() -> Bool {
        switch self.client.connect(timeout: self.TIMEOUT) {
            case .success:
                if let resultData = self.client.read(self.DATALEN) {
                    let result = String.init(bytes: resultData, encoding: String.Encoding.utf8)
                    
//                    if let version = self.stripResult(result: result!, part: 2) {
//                        self.version = version
//                        print("Connection open: \(version)")
//                        return true
//                    }
                }

            default: break
        }
        
        return false
    }
    
    public func disconnect() {
        self.client.close()
    }
}
