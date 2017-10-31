//
//  OfferCell.swift
//  Mapdealz
//
//  Created by Soeb on 10/27/17.
//  Copyright © 2017 soeb. All rights reserved.
//

import Foundation
import UIKit

class OfferCollectionCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupShadow()
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let offerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = #colorLiteral(red: 0.9332134783, green: 0.9320175516, blue: 0.9529074119, alpha: 1)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let businessLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = UIViewContentMode.center
        imageView.backgroundColor = #colorLiteral(red: 0.9267999115, green: 0.9267999115, blue: 0.9267999115, alpha: 1)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    func setupShadow() {
        self.layer.cornerRadius = 12
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 1
        self.layer.masksToBounds = true
    }
    
    
    func setupViews() {

        addSubview(businessLogo)
        businessLogo.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        businessLogo.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        businessLogo.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -10).isActive = true
        businessLogo.heightAnchor.constraint(equalToConstant: (self.frame.height * 0.25)).isActive = true
        
        addSubview(offerImageView)
        offerImageView.topAnchor.constraint(equalTo: businessLogo.bottomAnchor).isActive = true
        offerImageView.rightAnchor.constraint(equalTo: businessLogo.rightAnchor).isActive = true
        offerImageView.widthAnchor.constraint(equalTo: businessLogo.widthAnchor).isActive = true
        offerImageView.heightAnchor.constraint(equalToConstant: (self.frame.height * 0.65)).isActive = true
        
        
        
    }
    
    
}

