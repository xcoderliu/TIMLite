//
//  Utils.swift
//  TIMLite
//
//  Created by xcoderliu on 10/29/19.
//  Copyright © 2019 xcoderliu. All rights reserved.
//

import UIKit

//MARK: - 全局方法
func xcoderPrint(_ content: String, color: UIColor = .white) {
    TinyConsole.print(content, color: color)
}

func xcoderPass(_ content: String) {
    TinyConsole.print(content, color: .green)
}

func xcoderError(_ content: String) {
    TinyConsole.error(content)
}

func xcoderMark(_ content: String) {
    TinyConsole.print(content, color: .blue)
}

func imMark(_ content: String) {
    let im_debug = "im-debug: " + content
    xcoderMark(im_debug)
}

func imPrint(_ content: String, color: UIColor = .white) {
    let im_debug = "im-debug: " + content
   xcoderPrint(im_debug, color: color)
}

func imPass(_ content: String) {
    let im_debug = "im-debug: " + content
    xcoderPass(im_debug)
}

func imError(_ content: String) {
    let im_debug = "im-debug: " + content
    xcoderError(im_debug)
}

//MARK: - 扩展
//随机字符串
extension String {
    static let random_str_characters = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
    static func randomStr(len : Int) -> String{
        var ranStr = ""
        for _ in 0..<len {
            let index = Int(arc4random_uniform(UInt32(random_str_characters.count)))
            ranStr.append(random_str_characters[random_str_characters.index(random_str_characters.startIndex, offsetBy: index)])
        }
        return ranStr
    }
}

//MARK: - IM工具类
class IMUtils: NSObject {
    public static let shared = IMUtils()
    private override init(){}
    
    //MARK: - system
    
    var hasTopNotch: Bool {
        if #available(iOS 11.0, tvOS 11.0, *) {
            return UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0 > 20
        }
        return false
    }
    
    var statusBar_Height: CGFloat {
        return  hasTopNotch ? 44 : 20
    }
    
    let navBar_Height: CGFloat = 44
    
    var appDelegate: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    //MARK: - IM
    
    func genTestUserSig(identifier: String) -> String {
        return GenerateTestUserSig.genTestUserSig(identifier)
    }
    
    func setupAPNS(){
        guard let token = appDelegate._deviceToken else {
            return
        }
//        let config = V2TIMAPNSConfig.init()
//        config.token = token
//        config.busiId = timSdkBusiId
//
//        V2TIMManager.sharedInstance()?.setAPNS(config, succ: {
//            imPass("setAPNS success")
//        }, fail: { (code, errorDes) in
//            imError("setAPNS failed : code: \(code) error:\(errorDes ?? "nil")")
//        })
        let tokenParam = TIMTokenParam.init()
        tokenParam.token = token
        tokenParam.busiId = UInt32(timSdkBusiId)
        TIMManager.sharedInstance()?.setToken(tokenParam, succ: {
            imPass("setToken success")
            let config = TIMAPNSConfig.init()
            config.openPush = 0
            config.c2cSound = "00.caf"
            config.groupSound = "01.caf"
            TIMManager.sharedInstance()?.setAPNS(config, succ: {
                imPass("setAPNS success")
            }, fail: { (code, errorDes) in
                imError("setAPNS failed, code:\(code), error: \(errorDes ?? "nil")")
            })
        }, fail: { (code, errorDes) in
            imError("setToken failed, code:\(code), error: \(errorDes ?? "nil")")
        })
        
    }
    
    //MARK: - UI
    
    func showMainController() {
        appDelegate.showMainConroller()
    }
    
    func showLoginController() {
        appDelegate.showLoginController()
    }
    
    func TUIKitResourcePath(name: String) -> String {
        return Bundle.main.path(forResource: "TUIKitResource", ofType: "bundle") == nil ?
            (((Bundle.main.resourcePath! as NSString).appendingPathComponent("Frameworks/TXIMSDK_TUIKit_iOS.framework/TUIKitResource.bundle")) as NSString).appendingPathComponent(name) :
            (Bundle.main.path(forResource: "TUIKitResource", ofType: "bundle")! as NSString).appendingPathComponent(name)
    }
    
    func isDebugMode() -> Bool {
#if DEBUG
        return false
#else
        return false
#endif
    }
}
