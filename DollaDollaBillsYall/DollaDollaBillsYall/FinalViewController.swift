//
//  FinalViewController.swift
//  DollaDollaBillsYall
//
//  Created by Soeb on 3/6/17.
//  Copyright © 2017 soeb. All rights reserved.
//

import UIKit

class FinalViewController: UIViewController, UIGestureRecognizerDelegate{
    let reverbtn: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("StartOver", for: .normal)
        button.backgroundColor = .lightGray
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(handleOver), for: .touchUpInside)
        button.isUserInteractionEnabled = true
        return button
    }()
    var slideAnimation:AnimationHandler?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.addSubview(reverbtn)
        reverbtn.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        reverbtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        reverbtn.widthAnchor.constraint(equalToConstant: 90).isActive = true
        reverbtn.heightAnchor.constraint(equalToConstant: 40).isActive = true

    }
    


    func handleOver() {

        dismiss(animated: true, completion: nil)
    }
    

    
}
