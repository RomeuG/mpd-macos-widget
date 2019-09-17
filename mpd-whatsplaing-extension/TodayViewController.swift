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
    
    var mpdClient: MPDClient? = nil
    
    let ipAddress: String = "localhost"
    let defaultPort: Int = 6600
    
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

    }
    
    @IBAction func btnPlayAction(_ sender: Any) {

    }
    
    @IBAction func btnNextAction(_ sender: Any) {

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mpdClient = MPDClient(ipAddress: ipAddress, port: defaultPort)
    }
}
