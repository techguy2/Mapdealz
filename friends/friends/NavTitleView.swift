//
//  LoginView.swift
//  friends
//
//  Created by Soeb on 2/13/17.
//  Copyright © 2017 Soeb. All rights reserved.
//

import UIKit

class NavTitleView:UIView{
    
    let profileImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let nameTextField : UITextField = {
        let nameField = UITextField()
        nameField.translatesAutoresizingMaskIntoConstraints = false
        return nameField
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame:CGRect){
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        addSubview(containerView)
        // Add x, y, w, height constraints
        containerView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        containerView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        
        containerView.addSubview(profileImageView)
        // Add x, y, w and height constraints
        profileImageView.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        profileImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        containerView.addSubview(nameTextField)
        nameTextField.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 8).isActive = true
        nameTextField.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        nameTextField.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        nameTextField.heightAnchor.constraint(equalTo: profileImageView.heightAnchor).isActive = true
        
    }
}
