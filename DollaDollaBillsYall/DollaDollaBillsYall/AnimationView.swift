//
//  AnimationView.swift
//  DollaDollaBillsYall
//
//  Created by Soeb on 3/3/17.
//  Copyright © 2017 soeb. All rights reserved.
//

import UIKit

class AnimationView:UIView {
    
    let ball:UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "ball")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(ball)
        ball.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        ball.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        ball.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        ball.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
    }
}
