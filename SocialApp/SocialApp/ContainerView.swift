//
//  ContainerView.swift
//  SocialApp
//
//  Created by Soeb on 8/3/17.
//  Copyright © 2017 soeb. All rights reserved.
//

import UIKit

class ContainerView: UIView {
    
    let nameText: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Name"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let nameSeperator : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let emailText: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let emailSeperator : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let passwordText: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    var viewNameDisplay:Bool?
    var nameTextHeightAnchor: NSLayoutConstraint?
    var emailTextHeightAnchor:NSLayoutConstraint?
    var passwordTextHeightAchor:NSLayoutConstraint?
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        setupView()
        setupViewLayout()
        
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    func setupView() {
        self.addSubview(nameText)
        self.addSubview(nameSeperator)
        self.addSubview(emailText)
        self.addSubview(emailSeperator)
        self.addSubview(passwordText)

    }
    
    func setupViewLayout() {
        
        nameText.leftAnchor.constraint(equalTo: self.leftAnchor , constant: 10).isActive = true
        nameText.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        nameText.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        nameTextHeightAnchor = nameText.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/3)
        nameTextHeightAnchor?.isActive = true

        nameSeperator.topAnchor.constraint(equalTo: nameText.bottomAnchor).isActive = true
        nameSeperator.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        nameSeperator.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        nameSeperator.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        
        emailText.leftAnchor.constraint(equalTo: self.leftAnchor , constant: 10).isActive = true
        emailText.topAnchor.constraint(equalTo: nameSeperator.bottomAnchor).isActive = true
        emailText.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        emailTextHeightAnchor = emailText.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/3)
        emailTextHeightAnchor?.isActive = true
        
        emailSeperator.topAnchor.constraint(equalTo: emailText.bottomAnchor).isActive = true
        emailSeperator.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        emailSeperator.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        emailSeperator.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        
        
        passwordText.leftAnchor.constraint(equalTo: self.leftAnchor , constant: 10).isActive = true
        passwordText.topAnchor.constraint(equalTo: emailSeperator.bottomAnchor).isActive = true
        passwordText.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        passwordTextHeightAchor = passwordText.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/3)
        passwordTextHeightAchor?.isActive = true
        

        
    }
    
    func setupLoginView() {
        if viewNameDisplay == true {
        nameTextHeightAnchor?.isActive = false
        nameText.isHidden = true
        nameTextHeightAnchor = nameText.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0)
        nameTextHeightAnchor?.isActive = true
            
        emailTextHeightAnchor?.isActive = false
        emailTextHeightAnchor = emailText.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/2)
        emailTextHeightAnchor?.isActive = true
            
        passwordTextHeightAchor?.isActive = false
        passwordTextHeightAchor = passwordText.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/2)
        passwordTextHeightAchor?.isActive = true

        }
        else {
            nameTextHeightAnchor?.isActive = false
            nameText.isHidden = false
            nameTextHeightAnchor = nameText.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/3)
            nameTextHeightAnchor?.isActive = true
            
            emailTextHeightAnchor?.isActive = false
            emailTextHeightAnchor = emailText.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/3)
            emailTextHeightAnchor?.isActive = true
            
            passwordTextHeightAchor?.isActive = false
            passwordTextHeightAchor = passwordText.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/3)
            passwordTextHeightAchor?.isActive = true


        }
        
    }
    
    
    
}
