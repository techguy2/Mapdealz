//
//  Helper.swift
//  Yourtube
//
//  Created by Soeb on 2/10/17.
//  Copyright © 2017 Soeb. All rights reserved.
//

import UIKit

extension UIView{
    
    func addConstraintsWithFormat(format: String, views: UIView...)  {
        
        var dictionary = [String:AnyObject]()
        
        for (index , view) in views.enumerated(){
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            dictionary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: dictionary))

        
    }
    
}
