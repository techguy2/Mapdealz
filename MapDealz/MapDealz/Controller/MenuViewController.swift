//
//  MenuViewController.swift
//  Mapdealz
//
//  Created by Soeb on 10/20/17.
//  Copyright © 2017 soeb. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    let button : UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(handleDismiss), for: UIControlEvents.touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.383063972, green: 0.8539191484, blue: 0.7478803992, alpha: 1)
        view.addSubview(button)
        setupView()
    }


    
    func setupView() {
        button.topAnchor.constraint(equalTo: self.view.topAnchor , constant: 27).isActive = true
        button.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -40).isActive = true
        button.widthAnchor.constraint(equalToConstant : 90).isActive = true
        button.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
    }
    
    
    @objc func handleDismiss() {
        self.dismiss(animated: true, completion: nil)
    }
}



