//
//  ViewController.swift
//  AnimateView
//
//  Created by Soeb on 3/26/17.
//  Copyright © 2017 soeb. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let pathView = Curve(frame: self.view.frame)
        pathView.backgroundColor = .white
        view.addSubview(pathView)
        
    }



}

