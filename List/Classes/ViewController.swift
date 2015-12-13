//
//  ViewController.swift
//  List
//
//  Copyright (C) 2015 Xiao Yao. All Rights Reserved.
//  See LICENSE.txt for more information.
//

import UIKit

class ViewController: UINavigationController {
    required init?(coder aDecoder: NSCoder) {
        let listVC: ListViewController
        if let list = NSUserDefaults.groupUserDefaults().loadList() {
            listVC = ListViewController.init(list: list)
        } else {
            let list = List.init(title: "My List")
            listVC = ListViewController.init(list: list)
        }
        super.init(rootViewController: listVC)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.translucent = false
    }
}

