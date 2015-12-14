//
//  TodayViewController.swift
//  Today
//
//  Copyright (C) 2015 Xiao Yao. All Rights Reserved.
//  See LICENSE.txt for more information.
//

import UIKit
import NotificationCenter
import ListKit

class TodayViewController: UITableViewController, NCWidgetProviding {
    let list: List
    
    override init(style: UITableViewStyle) {
        if let list = NSUserDefaults.groupUserDefaults().loadList() {
            self.list = list
        } else {
            self.list = List.init(title: "")
        }
        
        print(self.list.items)
        super.init(style: style)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.preferredContentSize = CGSizeMake(0.0, CGFloat(self.list.items.count) * 44.0)
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: NSStringFromClass(UITableViewCell.self))
        
        print(self.preferredContentSize)
    }
    
    // MARK: NCWidgetProviding
        
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.

        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        completionHandler(NCUpdateResult.NewData)
    }
    
    // MARK: UITableViewDataSource
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.items.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(NSStringFromClass(UITableViewCell.self), forIndexPath: indexPath)
        
        let item = self.list.items[indexPath.row]
        cell.textLabel?.text = item.title
        cell.accessoryType = item.completed ? .Checkmark : .None
        
        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            self.list.items.removeAtIndex(indexPath.row)
            self.list.save()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        if sourceIndexPath.row != destinationIndexPath.row {
            let item = self.list.items[sourceIndexPath.row]
            self.list.items.removeAtIndex(sourceIndexPath.row)
            self.list.items.insert(item, atIndex: destinationIndexPath.row)
            self.list.save()
        }
    }
    
    // MARK: UITableViewDelegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let item = self.list.items[indexPath.row]
        item.completed = !item.completed
        self.list.save()
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell?.accessoryType = item.completed ? .Checkmark : .None
    }
}
