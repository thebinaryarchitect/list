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
class ListViewController : UITableViewController {
    // The list
    var list: List?
    
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
}