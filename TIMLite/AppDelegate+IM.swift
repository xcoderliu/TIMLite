//
//  AppDelegate+IM.swift
//  TIMLite
//
//  Created by xcoderliu on 11/27/19.
//  Copyright © 2019 xcoderliu. All rights reserved.
//

import UIKit

class IMTabBarController: TUITabBarController {
    deinit {
        imPrint("deinit \(self)")
    }
}


extension AppDelegate {
    
    /// 展示主视图
    func showMainConroller() {
        if let _ = window?.rootViewController {
            if let _ = TinyConsole.shared.consoleController.rootViewController as? IMTabBarController {
                return
            }
            if let loginVC = TinyConsole.shared.consoleController.rootViewController as? LoginViewController {
                loginVC.signEnterImage.isHidden = true
            }
            UIView.animate(withDuration: 0.25, animations: {
                if let loginVC = TinyConsole.shared.consoleController.rootViewController as? LoginViewController {
                    loginVC.signButton.transform = CGAffineTransform(scaleX: 28, y: 28)
                } else {
                    TinyConsole.shared.consoleController.rootViewController.view.alpha = 0.0
                }
            }) { _ in
                TinyConsole.shared.consoleController.rootViewController = self.mainVC
            }
        } else {
            window?.rootViewController = TinyConsole.createViewController(rootViewController: self.mainVC)
            showDebugConsole()
        }
    }
    
    func showLoginController() {
        if let _ = window?.rootViewController {
            if let _ = TinyConsole.shared.consoleController.rootViewController as? LoginViewController {
                return
            }
            UIView.animate(withDuration: 0.25, animations: {
                TinyConsole.shared.consoleController.rootViewController.view.alpha = 0.0
            }) { _ in
                TinyConsole.shared.consoleController.rootViewController = LoginViewController.init()
            }
        } else {
            window?.rootViewController = TinyConsole.createViewController(rootViewController: LoginViewController.init())
            showDebugConsole()
        }
    }
    
    func showDebugConsole() {
        xcoderPass("""
        /****************************************
          *Copyright(C),1998-2019,Tencent
          *Module:
          *Author:  xcoderliu
                *Version:  \(TIMManager.sharedInstance()?.getVersion() ?? "1.0")
          *Description:  used for im module debug
        ****************************************/
        """)
        if IMUtils.shared.isDebugMode() {
            TinyConsole.shared.consoleController.consoleWindowMode = .expanded
        }
        TinyConsole.shared.enableShake = true
    }
}
