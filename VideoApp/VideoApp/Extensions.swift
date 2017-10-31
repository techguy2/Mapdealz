//
//  Extensions.swift
//  VideoApp
//
//  Created by Soeb on 1/27/17.
//  Copyright © 2017 Soeb. All rights reserved.
//

import UIKit

extension UIView{
    
    
    func addConstraintFormat(format: String , views : UIView...)  {
        var viewsDictionary = [String:UIView]()
        for (index , view) in views.enumerated(){
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options:NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
        
        
    }
    
    
    
}

