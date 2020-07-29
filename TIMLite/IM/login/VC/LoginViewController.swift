//
//  LoginViewController.swift
//  TIMLite
//
//  Created by xcoderliu on 10/29/19.
//  Copyright © 2019 xcoderliu. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Material

class LoginViewController: UIViewController {

    internal let disposeBag = DisposeBag()
    internal let viewModel = loginViewModel()
    
    lazy var signButton: UIButton = {
        let sign = UIButton()
        sign.backgroundColor = UIColor(red: 48.0 / 255.0, green: 52.0 / 255.0, blue: 61.0 / 255.0, alpha: 1.0)
        sign.layer.cornerRadius = 40
        return sign
    }()
    
    lazy var signTip: UILabel = {
        let sign = UILabel()
        sign.text = "Sign in"
        sign.font = Font.boldSystemFont(ofSize: 24)
        sign.textColor = UIColor(red: 48.0 / 255.0, green: 52.0 / 255.0, blue: 61.0 / 255.0, alpha: 1.0)
        return sign
    }()
    
    lazy var signEnterImage: UIImageView = {
        let enter = UIImageView(image: UIImage(named: "signArrow"))
        enter.contentMode = .center
        return enter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpViews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    deinit {
        imPrint("deinit \(self)")
    }
    
    //MARK: - login
    
    func login() {
        viewModel.login()
    }
}
