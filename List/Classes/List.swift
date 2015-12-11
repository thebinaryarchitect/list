//
//  List.swift
//  List
//
//  Copyright (C) 2015 Xiao Yao. All Rights Reserved.
//  See LICENSE.txt for more information.
//

import Foundation

// Data model for an item that belongs to a list.
class ListItem {
    // A unique ID
    let identifier: String
    
    // The title
    var title = ""
    
    // Tracks the completion state
    var completed = false
    
    // Initialize a list item from a dictionary object.
    // The dictionary should conform to the following structure:
    //   identifier: String
    //   title: String
    //   completed: NSNumber
    init(dictionary: NSDictionary) {
        
        if let identifier = dictionary["identifier"] as? String {
            self.identifier = identifier
        } else {
            self.identifier = NSUUID.init().UUIDString
        }
        
        if let title = dictionary["title"] as? String {
            self.title = title
        } else {
            self.title = ""
        }
        
        if let completed = dictionary["completed"] as? NSNumber {
            self.completed = completed.boolValue
        } else {
            self.completed = false
        }
    }
    
    // Initialize an item with a title
    init(title: String) {
        self.identifier = NSUUID.init().UUIDString
        self.title = title
    }
}