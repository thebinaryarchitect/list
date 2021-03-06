//
//  NSUserDefaults+Lists.swift
//  List
//
//  Copyright (C) 2015 Xiao Yao. All Rights Reserved.
//  See LICENSE.txt for more information.
//

import Foundation

// The key used to store the list in user defaults.
let key = "com.thebinaryarchitect.ios.sample.list.savedlist"

// Adds persistance functionality to lists.
public extension NSUserDefaults {
    // Saves the list
    public func saveList(list: List) {
        let data = NSKeyedArchiver.archivedDataWithRootObject(list)
        self.setObject(data, forKey: key)
    }
    
    // Removes the list
    public func deleteList(list: List) {
        self.removeObjectForKey(key)
    }
    
    // Loads the list
    public func loadList() -> List? {
        if let data = self.objectForKey(key) as? NSData {
            if let list = NSKeyedUnarchiver.unarchiveObjectWithData(data) as? List {
                return list
            }
        }
        return nil
    }
    
    public class func groupUserDefaults() -> NSUserDefaults {
        return NSUserDefaults.init(suiteName: "group.com.thebinaryarchitect.sample.list")!
    }
}