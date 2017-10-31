//
//  NewMessageCell.swift
//  SocialApp
//
//  Created by Soeb on 8/16/17.
//  Copyright © 2017 soeb. All rights reserved.
//

import UIKit

class NewMessageCell: UITableViewCell {
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 30
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder)")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        addSubview(profileImageView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.textLabel?.frame.origin.x = 70
        self.detailTextLabel?.frame.origin.x = 70
        
        profileImageView.rightAnchor.constraint(equalTo: (self.textLabel?.leftAnchor)!, constant: -5).isActive = true
        profileImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        
        profileImageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
    }

}

