//
//  loginViewModel.swift
//  TIMLite
//
//  Created by xcoderliu on 11/27/19.
//  Copyright © 2019 xcoderliu. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
class loginViewModel: NSObject {
    var userName = BehaviorRelay<String>(value: "")
    var pwd = BehaviorRelay<String>(value: "")
    func login() {
        let user = userName.value
        let upwd = pwd.value
        assert(user.count > 0 || upwd.count > 0)
        let userSig = GenerateTestUserSig.genTestUserSig(user)
//        V2TIMManager.sharedInstance()?.login(user, userSig: userSig, succ: {
//            imPass("login success")
//            IMUtils.shared.setupAPNS()
//            IMUtils.shared.showMainController()
//        }, fail: { (code, errorDes) in
//
//        });
        let loginParam = TIMLoginParam.init()
        loginParam.identifier = user
        loginParam.userSig = userSig
        TIMManager.sharedInstance()?.login(loginParam, succ: {
            imPass("login success")
            IMUtils.shared.setupAPNS()
            IMUtils.shared.showMainController()
        }, fail: { (code, errorDes) in
            imError("login failed, code:\(code), error: \(errorDes ?? "nil")")
        })
    }
    
}
