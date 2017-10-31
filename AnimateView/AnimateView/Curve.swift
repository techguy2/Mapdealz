//
//  Curve.swift
//  AnimateView
//
//  Created by Soeb on 3/26/17.
//  Copyright © 2017 soeb. All rights reserved.
//

import UIKit

class Curve: UIView {

    override func draw(_ rect: CGRect) {
        let path = UIBezierPath()
        path.lineWidth = 3
        path.move(to: CGPoint(x: 0, y: rect.height/2))
        print(rect.width)
        path.addCurve(to: CGPoint(x:rect.width ,y: rect.height/2), controlPoint1: CGPoint(x: 100,y: rect.height/6), controlPoint2: CGPoint(x: 274,y: rect.height/4))
        path.stroke()
        
    }
}
