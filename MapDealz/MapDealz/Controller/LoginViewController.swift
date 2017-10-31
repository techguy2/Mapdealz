//
//  LoginViewController.swift
//  Mapdealz
//
//  Created by Soeb on 10/20/17.
//  Copyright © 2017 soeb. All rights reserved.
//

import UIKit
import GoogleSignIn

class LoginViewController: UIViewController, GIDSignInUIDelegate {
    
    let loginButton = GIDSignInButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.blue
        GIDSignIn.sharedInstance().clientID = "413035924421-s23p2a2kt013prrdi9d6q4tkicqluh45.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self as GIDSignInUIDelegate

        setupViews()
        
    }

    func setupViews() {
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginButton)
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80).isActive = true
        loginButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -20).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
    }
    
 
}

extension LoginViewController: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if error == nil {
            print(user.profile.email)
            print(user.profile.imageURL(withDimension: 300))
            dismiss(animated: true, completion: nil)
        } else {
            print(error.localizedDescription)
        }
    }
    
    
}



