//
//  ChatMessageCell.swift
//  friends
//
//  Created by Soeb on 2/25/17.
//  Copyright © 2017 Soeb. All rights reserved.
//

import UIKit

class ChatMessageCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let textView:UITextView = {
        let tv = UITextView()
        tv.textColor = UIColor.white
        tv.font = UIFont.systemFont(ofSize: 16)
        tv.backgroundColor = UIColor.clear
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 15
        imageView.layer.masksToBounds = true
//        imageView.backgroundColor = .black
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let bubbleView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0, green: 137, blue: 249)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()
    
    func setupView() {
        addSubview(profileImageView)
        addSubview(bubbleView)
        setupBubbleViewConstraints()
    }
    
    var bubbleWidthAnchor:NSLayoutConstraint?
    var bubbleRightAnchor:NSLayoutConstraint?
    var bubbleLeftAnchor:NSLayoutConstraint?
    
    func setupBubbleViewConstraints() {
        
        profileImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        profileImageView.bottomAnchor.constraint(equalTo: bubbleView.bottomAnchor).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true

        
        bubbleLeftAnchor = bubbleView.leftAnchor.constraint(equalTo: profileImageView.rightAnchor , constant: 8)
        bubbleLeftAnchor?.isActive = false
        bubbleRightAnchor = bubbleView.rightAnchor.constraint(equalTo: self.rightAnchor , constant: -8)
        bubbleRightAnchor?.isActive = true
        bubbleView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        bubbleWidthAnchor = bubbleView.widthAnchor.constraint(equalToConstant: 250)
        bubbleWidthAnchor?.isActive = true
        bubbleView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        
        bubbleView.addSubview(textView)
        self.textView.leftAnchor.constraint(equalTo: self.bubbleView.leftAnchor , constant: 8).isActive = true
        self.textView.topAnchor.constraint(equalTo: self.bubbleView.topAnchor).isActive = true
        self.textView.widthAnchor.constraint(equalTo: self.bubbleView.widthAnchor, constant: -8).isActive = true
        self.textView.heightAnchor.constraint(equalTo: self.bubbleView.heightAnchor).isActive = true


    }
}
