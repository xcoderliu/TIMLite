//
//  ChatController.swift
//  TIMLite
//
//  Created by xcoderliu on 11/29/19.
//  Copyright © 2019 xcoderliu. All rights reserved.
//

import UIKit

class ChatController: UIViewController {
    
    let convData: TUIConversationCellData
    let chat: TUIChatController

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }
    
    init(data: TUIConversationCellData) {
        convData = data
        let conv = TIMManager.sharedInstance()?.getConversation(convData.convType, receiver: convData.convId)
        chat = TUIChatController.init(conversation: conv)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
          imPrint("deinit \(self)")
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
