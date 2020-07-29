//
//  ChatController+Delegate.swift
//  TIMLite
//
//  Created by xcoderliu on 11/29/19.
//  Copyright © 2019 xcoderliu. All rights reserved.
//

import UIKit

extension ChatController: TUIChatControllerDelegate {
    
    func chatController(_ controller: TUIChatController!, didSendMessage msgCellData: TUIMessageCellData!) {
        imPrint("send message: \((msgCellData.innerMessage.getElem(0)?.classForCoder)!) to \(convData.convId)")
    }
    
    func chatController(_ controller: TUIChatController!, onNewMessage msg: TIMMessage!) -> TUIMessageCellData! {
        
        return nil
    }
    
    func chatController(_ controller: TUIChatController!, onShowMessageData cellData: TUIMessageCellData!) -> TUIMessageCell! {
        return nil
    }
    
    func chatController(_ chatController: TUIChatController!, onSelect cell: TUIInputMoreCell!) {
        
    }
    
    func chatController(_ controller: TUIChatController!, onSelectMessageAvatar cell: TUIMessageCell!) {
        
    }
    
    func chatController(_ controller: TUIChatController!, onSelectMessageContent cell: TUIMessageCell!) {
        
    }
}
