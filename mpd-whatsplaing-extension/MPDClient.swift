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
                    return true
//                    let result = String.init(bytes: resultData, encoding: String.Encoding.utf8)
//
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
    
    private func sendCommand(command: String, resultHandler:@escaping (String?) -> Void) {
        DispatchQueue.global(qos: DispatchQoS.QoSClass.background).async {
            var response: String = ""

            if self.connect() == true {
                // mpd wants \n terminating command
                switch self.client.send(string: "\(command)\n") {
                case .success:
                    // read as long as the response is not finished
                    while true {
                        if let responseData = self.client.read(self.DATALEN) {
                            if let append = String.init(bytes: responseData, encoding: String.Encoding.utf8) {
                                response.append(append)
                                
                                // if finisheds with MPD's OK status, response is complete
                                if response.hasSuffix("OK\n") {
                                    break
                                }
                            }
                        }
                    }
                default: break
                }

                self.disconnect()
            }
            
            DispatchQueue.main.async {
                if (response.isEmpty || response == "OK\n") {
                    resultHandler(nil)
                }
                else {
                    resultHandler(response)
                }
            }
        }
    }
}
