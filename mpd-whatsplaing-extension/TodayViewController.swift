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
    
    let ipAddress: String = "127.0.0.1"
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
        let result = tcpClient?.send(data: "previous".data(using: .utf8)!)
        print("btnPrevious result: \(String(describing: result))")
    }
    
    @IBAction func btnPlayAction(_ sender: Any) {
        let result = tcpClient?.send(data: "pause".data(using: .utf8)!)
        print("btnPlay result: \(String(describing: result))")
    }
    
    @IBAction func btnNextAction(_ sender: Any) {
        let result = tcpClient?.send(data: "next".data(using: .utf8)!)
        print("btnNext result: \(String(describing: result))")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tcpClient = TCPClient(address: ipAddress, port: defaultPort)
        
        switch tcpClient?.connect(timeout: 10) {
        case .success:
            print("Success!")
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
