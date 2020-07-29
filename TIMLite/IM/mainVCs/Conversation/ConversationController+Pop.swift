//
//  ConversationController+Pop.swift
//  TIMLite
//
//  Created by xcoderliu on 11/29/19.
//  Copyright © 2019 xcoderliu. All rights reserved.
//

import UIKit

extension ConversationController: TPopViewDelegate {
    
    func setupRightItem() {
        let moreButton = UIButton.init(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        moreButton.setImage(UIImage(named: IMUtils.shared.TUIKitResourcePath(name: "more")), for: .normal)
        
        moreButton.rx.controlEvent(.touchUpInside).subscribe(onNext: { [weak mo = moreButton, weak self] in
            guard let mo = mo else {return}
            guard let self = self else {return}
            var meuns:[TPopCellData] = []
            
            let friend = TPopCellData.init()
            friend.image = IMUtils.shared.TUIKitResourcePath(name: "add_friend")
            friend.title = "发起会话"
            meuns.append(friend)
            
            let discuss = TPopCellData.init()
            discuss.image = IMUtils.shared.TUIKitResourcePath(name: "create_group")
            discuss.title = "创建讨论组"
            meuns.append(discuss)
            
            let group = TPopCellData.init()
            group.image = IMUtils.shared.TUIKitResourcePath(name: "create_group")
            group.title = "创建群聊"
            meuns.append(group)
            
            let room = TPopCellData.init()
            room.image = IMUtils.shared.TUIKitResourcePath(name: "create_group")
            room.title = "创建聊天室"
            meuns.append(room)
            let height = TPopCell.getHeight() * CGFloat(meuns.count) + 10.0
            let originY = IMUtils.shared.navBar_Height + IMUtils.shared.statusBar_Height
            let popView = TPopView.init(frame: CGRect(x: UIScreen.main.bounds.width - 145, y: originY, width: 135, height: height))
            let frameInNaviView = self.navigationController?.view.convert(mo.frame, to: mo.superview)
            popView.arrowPoint = CGPoint(x: (frameInNaviView?.origin.x ?? 0) + (frameInNaviView?.size.width ?? 0) * 0.5, y: originY)
            popView.tableView.layer.cornerRadius = 4.0
            popView.layer.cornerRadius = 4.0
            popView.setData(NSMutableArray.init(array: meuns))
            popView.show(in: self.view.window)
            
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
        
        let moreItem = UIBarButtonItem.init(customView: moreButton)
        navigationItem.rightBarButtonItem = moreItem
    }
    
    func popView(_ popView: TPopView!, didSelectRowAt index: Int) {
           
       }
}
