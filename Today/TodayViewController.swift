//
//  TodayViewController.swift
//  Today
//
//  Copyright (C) 2015 Xiao Yao. All Rights Reserved.
//  See LICENSE.txt for more information.
//

import UIKit
import NotificationCenter
import List

class TodayViewController: UITableViewController, NCWidgetProviding {
    let list: List
    
    override init(style: UITableViewStyle) {
        if let list = NSUserDefaults.standardUserDefaults().loadList() {
            self.list = list
        } else {
            self.list = List.init(title: "")
        }
        
        super.init(style: style)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: NCWidgetProviding
        
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.

        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        completionHandler(NCUpdateResult.NewData)
    }
}
