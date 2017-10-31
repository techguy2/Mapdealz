//
//  SendBtnView.swift
//  friends
//
//  Created by Soeb on 2/19/17.
//  Copyright © 2017 Soeb. All rights reserved.
//

import UIKit

class SendBtnView:UIView,UITextFieldDelegate{
    
    let sendButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Send", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
//        btn.addTarget(self, action: #selector(handleSend), for: .touchUpInside)
        return btn
    }()
    
    lazy var messageTextField: UITextField = {
        let text = UITextField()
        text.placeholder = "Enter Message..."
        text.translatesAutoresizingMaskIntoConstraints = false
        text.delegate = self
        return text
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
