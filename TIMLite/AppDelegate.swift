//
//  AppDelegate.swift
//  TIMLite
//
//  Created by xcoderliu on 10/29/19.
//  Copyright © 2019 xcoderliu. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var _deviceToken: Data?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        registNotification()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()

        // init IMSDK
        TUIKit.sharedInstance()?.setup(withAppId: Int(timSdkAppID))
        // auto login
//        V2TIMManager.sharedInstance()?.autoLogin({
//            imPrint("auto login success")
//        }, fail: { (code, errorDes) in
//            self.window?.rootViewController = LoginViewController()
//        })
        
        showLoginController()
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        _deviceToken = deviceToken
    }
    
    //set unread badgenumber
    func applicationDidEnterBackground(_ application: UIApplication) {
        var bgTaskID = UIBackgroundTaskIdentifier(rawValue: 0)
        bgTaskID = application.beginBackgroundTask(expirationHandler: {
            application.endBackgroundTask(bgTaskID)
            bgTaskID = .invalid
        })
        
        var unRead: Int32 = 0
        if let convs = TIMManager.sharedInstance()?.getConversationList() {
            for conv in convs {
                unRead = unRead + conv.getUnReadMessageNum()
            }
            UIApplication.shared.applicationIconBadgeNumber = Int(unRead)
            
            //do background
            let param = TIMBackgroundParam.init()
            param.c2cUnread = unRead
            TIMManager.sharedInstance()?.doBackground(param, succ: {
                imPass("set unread badge success")
            }, fail: { (code, errorDes) in
                imError("set unread badge failed, code: \(code), error: \(errorDes ?? "nil")")
            })
        }
        
        
    }
    
    //MARK: - main
    internal var mainVC: IMTabBarController {
        let tabvc = IMTabBarController.init()
        let items = NSMutableArray.init(capacity: 1)
        
        let msgItem = TUITabBarItem.init()
        msgItem.title = "消息"
        msgItem.selectedImage = UIImage(named: "session_selected")
        msgItem.normalImage = UIImage(named: "session_normal")
        msgItem.controller = TNavigationController.init(rootViewController: ConversationController.init())
        items.add(msgItem)
        
        let contactItem = TUITabBarItem.init()
        contactItem.title = "通讯录"
        contactItem.selectedImage = UIImage(named: "contact_selected")
        contactItem.normalImage = UIImage(named: "contact_normal")
        contactItem.controller = TNavigationController.init(rootViewController: ContactController.init())
        items.add(contactItem)
        
        let myselfItem = TUITabBarItem.init()
        myselfItem.title = "我"
        myselfItem.selectedImage = UIImage(named: "myself_selected")
        myselfItem.normalImage = UIImage(named: "myself_normal")
        myselfItem.controller = TNavigationController.init(rootViewController: ViewController.init())
        items.add(myselfItem)
        
        tabvc.tabBarItems = items
        return tabvc
    }
    
    //MARK: - notification
    func registNotification() {
        if (UIDevice.current.systemVersion as NSString).floatValue >= 8.0 {
            UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings.init(types: [.sound, .alert, .badge], categories: nil))
            UIApplication.shared.registerForRemoteNotifications()
        } else {
            UIApplication.shared.registerForRemoteNotifications(matching: [.sound, .alert, .badge])
        }
    }
    
}

