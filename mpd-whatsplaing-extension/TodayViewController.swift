//
//  TodayViewController.swift
//  mpd-whatsplaing-extension
//
//  Created by Romeu Vieira da Silva Gomes on 08/09/2019.
//  Copyright © 2019 Romeu Vieira da Silva Gomes. All rights reserved.
//

import Cocoa
import NotificationCenter
import SwiftSocket

class TodayViewController: NSViewController, NCWidgetProviding {
    
    @IBOutlet weak var btnPlayPause: NSButton!
    @IBOutlet weak var btnNext: NSButton!
    @IBOutlet weak var btnPrevious: NSButton!
    
    var tcpClient: TCPClient? = nil;
    
    let ipAddress: String = "localhost"
    let defaultPort: Int32 = 6600
    
    override var nibName: NSNib.Name? {
        return NSNib.Name("TodayViewController")
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Update your data and prepare for a snapshot. Call completion handler when you are done
        // with NoData if nothing has changed or NewData if there is new data since the last
        // time we called you
        completionHandler(.noData)
    }
    
    @IBAction func btnPreviousAction(_ sender: Any) {
        switch tcpClient?.send(data: "previous".data(using: .utf8)!) {
        case .success:
            guard let response = tcpClient?.read(1024*10) else { return }
            let response_str: String = String(bytes: response, encoding: .utf8) ?? ""
            
            print("btnPreviousAction response: \(response_str)")
        case .failure(let error):
            print("btnPreviousAction read failure: \(error.localizedDescription)")
        case .none:
            print("Unknown error!")
        }
    }
    
    @IBAction func btnPlayAction(_ sender: Any) {
        switch tcpClient?.send(data: "pause".data(using: .utf8)!) {
        case .success:
            let response = (tcpClient?.read(1024*10))!
            let response_str: String = String(bytes: response, encoding: .utf8) ?? ""
            
            print("btnPlayAction response: \(response_str)")
        case .failure(let error):
            print("btnPlayAction read failure: \(error.localizedDescription)")
        case .none:
            print("Unknown error!")
        }
    }
    
    @IBAction func btnNextAction(_ sender: Any) {
        switch tcpClient?.send(data: "next".data(using: .utf8)!) {
        case .success:
            guard let response = tcpClient?.read(1024*10) else { return }
            let response_str: String = String(bytes: response, encoding: .utf8) ?? ""
            
            print("btnNextAction response: \(response_str)")
        case .failure(let error):
            print("btnNextAction read failure: \(error.localizedDescription)")
        case .none:
            print("Unknown error!")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tcpClient = TCPClient(address: ipAddress, port: defaultPort)
        
        switch tcpClient?.connect(timeout: 10) {
        case .success:
            print("Success!")
            
            guard let response = tcpClient?.read(1024*10) else { return }
            let response_str: String = String(bytes: response, encoding: .utf8) ?? ""
            
            print("Initial connection response: \(response_str)")
            
        case .failure(let error):
            print("Failure: \(error.localizedDescription)")
            
            btnPlayPause.isEnabled = false
            btnPrevious.isEnabled = false
            btnNext.isEnabled = false
        case .none:
            print("None!")
        }
    }
}
