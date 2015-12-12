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
    
    override func viewDidLoad() {
        self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        let frame = self.navigationController?.navigationBar.frame
        let textField = UITextField.init(frame: frame!)
        textField.delegate = self
        textField.placeholder = "Add List Item"
        self.navigationItem.titleView = textField
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: NSStringFromClass(UITableViewCell.self))
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
            self.list.items.insert(item, atIndex: destinationIndexPath.row)
            self.list.save()
        }
    }
    
    // MARK: Private
    
    func addItem(text: String) {
        if !text.isEmpty {
            let item = ListItem.init(title: text)
            self.list.items.append(item)
            self.list.save()
            let indexPath = NSIndexPath.init(forRow: self.list.items.count-1, inSection: 0)
            self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
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
    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if let text = textField.text {
            self.addItem(text)
            textField.text = nil
            return false
        }
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        if let text = textField.text {
            self.addItem(text)
            textField.text = nil
        }
    }
}