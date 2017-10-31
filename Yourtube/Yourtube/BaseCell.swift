//
//  BaseCell.swift
//  Yourtube
//
//  Created by Soeb on 2/11/17.
//  Copyright © 2017 Soeb. All rights reserved.
//

import UIKit

class BaseCell:UICollectionViewCell{
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupView(){
        
    }
}
