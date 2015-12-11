//
//  List.swift
//  List
//
//  Copyright (C) 2015 Xiao Yao. All Rights Reserved.
//  See LICENSE.txt for more information.
//

import Foundation

// Data model for an item that belongs to a list.
class ListItem : NSObject {
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
        }
        
        if let completed = dictionary["completed"] as? NSNumber {
            self.completed = completed.boolValue
        }
        
        super.init()
    }
    
    // Initialize an item with a title
    init(title: String) {
        self.identifier = NSUUID.init().UUIDString
        self.title = title
    }
}

// Data model for a list
class List : NSObject {
    // A unique ID
    let identifier: String
    
    // The title
    var title = ""
    
    // List items
    var items: [ListItem]
    
    // Initializes a list from a dictionary object.
    // The dictionary should conform to the following structure:
    //   identifier: String
    //   title: String
    //   items: [ListItem]
    init(dictionary: NSDictionary) {
        if let identifier = dictionary["identifier"] as? String {
            self.identifier = identifier
        } else {
            self.identifier = NSUUID.init().UUIDString
        }
        
        if let title = dictionary["title"] as? String {
            self.title = title
        }
        
        if let items = dictionary["items"] as? [ListItem] {
            self.items = items
        } else {
            self.items = []
        }
        
        super.init()
    }
    
    // Initializes a list from a title.
    init(title: String) {
        self.identifier = NSUUID.init().UUIDString
        self.title = title
        self.items = []
    }
}