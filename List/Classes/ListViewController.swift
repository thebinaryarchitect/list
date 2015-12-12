//
//  ListViewController.swift
//  List
//
//  Copyright (C) 2015 Xiao Yao. All Rights Reserved.
//  See LICENSE.txt for more information.
//

import Foundation
import UIKit

// Controller for a list.
class ListViewController : UITableViewController, UITextFieldDelegate {
    // The list
    var list: List
    
    // Initialize with a list
    init(list: List) {
        self.list = list
        super.init(style: .Plain)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewDidLoad() {
        self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        let frame = self.navigationController?.navigationBar.frame
        let textField = UITextField.init(frame: frame!)
        textField.delegate = self
        textField.placeholder = "Add List Item"
        self.navigationItem.titleView = textField
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
        cell.accessoryType = item.completed ? UITableViewCellAccessoryType.Checkmark : UITableViewCellAccessoryType.None
        
        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            self.list.items.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        let item = self.list.items[sourceIndexPath.row]
        self.list.items.removeAtIndex(sourceIndexPath.row)
        self.list.items.insert(item, atIndex: destinationIndexPath.row)
    }
}