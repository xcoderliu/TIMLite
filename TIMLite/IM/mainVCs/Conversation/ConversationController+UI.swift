//
//  ConversationController+UI.swift
//  TIMLite
//
//  Created by xcoderliu on 11/27/19.
//  Copyright © 2019 xcoderliu. All rights reserved.
//

import UIKit
import SnapKit

extension ConversationController: TUIConversationListControllerDelegagte {
    //MARK: - UI
    func setupUI() {
        view.backgroundColor = .white
        let conv = TUIConversationListController.init()
        conv.delegate = self;
        addChild(conv)
        view.addSubview(conv.view)
        conv.view.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        conv.tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(conv.view)
        }
        
        conv.tableView.delaysContentTouches = false
        NotificationCenter.default.addObserver(self, selector: #selector(onNewMessage(noti:)),
                                               name: NSNotification.Name.init("TUIKitNotification_TIMMessageListener"),
                                               object: nil)
        
        setupRightItem()
        setupNavigation()
    }
    
    //MARK: - network
    
    func setupNavigation() {
        self.navigationItem.titleView = titleView;
        self.navigationItem.title = "";
    }
    
    func onConnectSucc() {
        titleView.setTitle("腾讯·云通信")
        titleView.stopAnimating()
    }
    
    func onConnecting() {
        titleView.setTitle("连接中...")
        titleView.startAnimating()
    }
    
    func onConnectFailed(_ code: Int32, err: String!) {
        titleView.setTitle("腾讯·云通信(未连接)")
        titleView.stopAnimating()
    }
    
    //MARK: - Message
    
    @objc func onNewMessage(noti: NSNotification) {
        if let msgs = noti.object as? [TIMMessage] {
            for msg in msgs {
                if let textElem = msg.getElem(0) as? TIMTextElem {
                    imPrint("onNewMessage \(msg.sender() ?? ""): \(textElem.text ?? "")",
                    color: UIColor(rgb: 0xd9d919))
                }
            }
        }
    }
    //MARK: - conv selected
    
    func conversationListController(_ conversationController: TUIConversationListController,
                                    didSelectConversation conversation: TUIConversationCell) {
        let chat = ChatController.init(data: conversation.convData)
        navigationController?.pushViewController(chat, animated: true)
    }
    
    //     func onNewMessage(msg: V2TIMMessage) {
    //        if let textElem = msg.elem as? V2TIMTextElem {
    //            imPrint("onNewMessage \(msg.sender ?? ""): \(textElem.text ?? "")",
    //                color: UIColor(rgb: 0xd9d919))
    //        }
    //    }
}
