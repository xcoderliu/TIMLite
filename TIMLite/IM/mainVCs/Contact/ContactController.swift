//
//  ContactController.swift
//  TIMLite
//
//  Created by xcoderliu on 11/29/19.
//  Copyright © 2019 xcoderliu. All rights reserved.
//

import Foundation

class ContactController: TUIContactController {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "通讯录"
        tableView.delaysContentTouches = false
        
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
    }
}
