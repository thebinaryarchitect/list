//
//  List.swift
//  List
//
//  Copyright (C) 2015 Xiao Yao. All Rights Reserved.
//  See LICENSE.txt for more information.
//

import Foundation

// Data model for an item that belongs to a list.
public class ListItem : NSObject, NSCoding {
    // A unique ID
    public let identifier: String
    
    // The title
    public var title = ""
    
    // Tracks the completion state
    public var completed = false
    
    // Initialize a list item from a dictionary object.
    // The dictionary should conform to the following structure:
    //   identifier: String
    //   title: String
    //   completed: NSNumber
    public init(dictionary: NSDictionary) {
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
    public init(title: String) {
        self.identifier = NSUUID.init().UUIDString
        self.title = title
    }
    
    // MARK: NSCoding
    
    public required init?(coder aDecoder: NSCoder) {
        if let identifier = aDecoder.decodeObjectForKey("identifier") as? String {
            self.identifier = identifier
        } else {
            self.identifier = NSUUID.init().UUIDString
        }
        
        if let title = aDecoder.decodeObjectForKey("title") as? String {
            self.title = title
        }
        
        if let completed = aDecoder.decodeObjectForKey("completed") as? NSNumber {
            self.completed = completed.boolValue
        }
    }
    
    public func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.identifier, forKey: "identifier")
        aCoder.encodeObject(self.title, forKey: "title")
        aCoder.encodeObject((self.completed), forKey: "completed")
    }
}

// Data model for a list
public  class List : NSObject, NSCoding {
    // A unique ID
    public let identifier: String
    
    // The title
    public var title = ""
    
    // List items
    public var items: [ListItem]
    
    // Initializes a list from a dictionary object.
    // The dictionary should conform to the following structure:
    //   identifier: String
    //   title: String
    //   items: [ListItem]
    public init(dictionary: NSDictionary) {
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
    public init(title: String) {
        self.identifier = NSUUID.init().UUIDString
        self.title = title
        self.items = []
    }
    
    // MARK: Public
    
    public func save() {
        NSUserDefaults.groupUserDefaults().saveList(self)
    }
    
    public func delete() {
        NSUserDefaults.groupUserDefaults().deleteList(self)
    }
    
    // MARK: NSCoding
    
    public required init?(coder aDecoder: NSCoder) {
        if let identifier = aDecoder.decodeObjectForKey("identifier") as? String {
            self.identifier = identifier
        } else {
            self.identifier = NSUUID.init().UUIDString
        }
        
        if let title = aDecoder.decodeObjectForKey("title") as? String {
            self.title = title
        }
        
        if let items = aDecoder.decodeObjectForKey("items") as? [ListItem] {
            self.items = items
        } else {
            self.items = []
        }
    }
    
    public func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.identifier, forKey: "identifier")
        aCoder.encodeObject(self.title, forKey: "title")
        aCoder.encodeObject(self.items, forKey: "items")
    }
}