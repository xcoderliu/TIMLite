//
//  ChatController+UI.swift
//  TIMLite
//
//  Created by xcoderliu on 11/29/19.
//  Copyright © 2019 xcoderliu. All rights reserved.
//

import UIKit

extension ChatController {
    
    func setupUI() {
        addChild(chat)
        view.addSubview(chat.view)
        chat.view.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        chat.delegate = self
    }
   
}
