//
//  LoginViewController+UI.swift
//  TIMLite
//
//  Created by xcoderliu on 11/27/19.
//  Copyright © 2019 xcoderliu. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Material

extension LoginViewController {
    // MARK: - UI
    func setUpViews() {
        view.backgroundColor = UIColor.white
        let backImage = UIImageView.init(image: UIImage(named: "loginBK"))
        view.addSubview(backImage)
        backImage.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        let welCome = UILabel.init()
        welCome.text = """
        Welcome to use
        Tencent Yun IM
        """
        welCome.textColor = .white
        welCome.font = Font.boldSystemFont(ofSize: 34)
        welCome.numberOfLines = 0
        view.addSubview(welCome)
        welCome.snp.makeConstraints { (make) in
            make.top.equalTo(IMUtils.shared.hasTopNotch ? 110 : 90)
            make.height.equalTo(IMUtils.shared.hasTopNotch ? 200 : 150)
            make.width.equalTo(self.view).multipliedBy(0.8)
            make.centerX.equalTo(self.view)
        }
        
        let userName = getTextObservable(placeholder: "Name",otherViews: nil) { [weak self] (tf:UITextField,views:[UIView?])  in
            guard let self = self else {return}
            tf.snp.makeConstraints({ (make) in
                make.width.equalTo(self.view).multipliedBy(0.8)
                make.height.equalTo(52)
                make.top.equalTo(welCome.snp.bottom).offset(120)
                make.centerX.equalTo(self.view)
            })
            //test code
            tf.text = "xcoderliu"
        }
        userName.subscribe(onNext: { (text) in
            print("username:\(String(describing: text))")
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
        userName.bind(to: viewModel.userName).disposed(by: disposeBag)
        
        let userPwd = getTextObservable(placeholder: "Password", otherViews: view.subviews[2] ,setUI: { [weak self] (tf:UITextField,views:[UIView?])  in
            guard let self = self else {return}
            tf.snp.makeConstraints({ (make) in
                make.width.equalTo(self.view).multipliedBy(0.8)
                make.height.equalTo(52)
                make.centerX.equalTo(self.view)
                make.top.equalTo(views[0]!.snp.bottom).offset(40)
            })
            tf.isSecureTextEntry = true
            //test code
            tf.text = "*****"
        })
        userPwd.subscribe(onNext: { (text) in
            print("password:\(String(describing: text))")
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
        userPwd.bind(to: viewModel.pwd).disposed(by: disposeBag)
        
        let userNameValid = userName
            .map {
                $0.count > 0
        }.share(replay: 1)
        userNameValid.subscribe(onNext: { (valid) in
            print("userNameValid:\(valid)")
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
        
        let userPwdValid = userPwd
            .map {
                $0.count > 0
        }.share(replay: 1)
        userPwdValid.subscribe(onNext: { (valid) in
            print("userPwdValid:\(valid)")
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
        
        let userNamePwdValid = Observable.combineLatest(userNameValid,userPwdValid){
            $0 && $1
        }.share(replay: 1)
        
        view.addSubview(signButton)
        signButton.snp.makeConstraints { (make) in
            make.trailing.equalTo(view.subviews[3])
            make.top.equalTo(view.subviews[3].snp.bottom).offset(28)
            make.width.height.equalTo(80)
        }
        
        view.addSubview(signEnterImage)
        signEnterImage.snp.makeConstraints { (make) in
            make.trailing.equalTo(view.subviews[3])
            make.top.equalTo(view.subviews[3].snp.bottom).offset(28)
            make.width.height.equalTo(80)
        }
        
        signButton.rx.controlEvent(.touchUpInside).subscribe(onNext: { [weak self] in
            guard let self = self else {return}
            self.login()
            }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
        
        userNamePwdValid.bind(to: signButton.rx.isEnabled).disposed(by: disposeBag)
        userNamePwdValid.subscribe(onNext: { [weak button=signButton](enabled) in
            button?.alpha = enabled ? 1 : 0.8
            }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
        
        view.addSubview(signTip)
        signTip.snp.makeConstraints { (make) in
            make.centerY.equalTo(signButton)
            make.leading.equalTo(view.subviews[3])
            make.width.equalTo(100)
            make.height.equalTo(40)
        }
        
        animation(welcome: welCome)
    }
    
    //MARK: - animation
    
    func animation(welcome: UILabel) {
        welcome.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
        var views: [UIView] = []
        for view in view.subviews {
            if view != welcome && !view.isKind(of: UIImageView.classForCoder()) {
                views.append(view)
                view.alpha = 0.0;
            }
        }
        
        UIView.animate(withDuration: 0.3) {
            welcome.transform = CGAffineTransform.identity
        }
        
        UIView.animate(withDuration: 1) {
            for view in views {
                view.alpha = 1.0;
            }
        }
    }
    
    //MARK: - inner functionnd
    func getTextObservable( placeholder:String = "🐉",
                            otherViews:UIView?...,
                            setUI:(_ tf:UITextField , _ Views:[UIView?])->Void) -> ControlProperty<String> {
        let edit = TextField()
        edit.textColor = .white
        edit.dividerThickness = 0.2
        edit.dividerActiveColor = .white
        edit.placeholderNormalColor = .white
        edit.placeholderActiveColor = .white
        edit.placeholderLabel.font = Font.boldSystemFont(ofSize: 18)
        view.addSubview(edit)
        edit.placeholder = placeholder
        setUI(edit,otherViews)
        return edit.rx.text.orEmpty
    }
}
