//
//  ConversationController.swift
//  TIMLite
//
//  Created by xcoderliu on 11/27/19.
//  Copyright © 2019 xcoderliu. All rights reserved.
//

import UIKit
import RxSwift

class ConversationController: UIViewController {
    let disposeBag = DisposeBag()
    
    lazy var titleView: TNaviBarIndicatorView = {
        let title = TNaviBarIndicatorView.init()
        title.setTitle("腾讯·云通信")
        return title
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        
        //test code
        DispatchQueue.global(qos: .userInteractive).async {
            self.testAPIV2()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        imPrint("deinit \(self)")
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
