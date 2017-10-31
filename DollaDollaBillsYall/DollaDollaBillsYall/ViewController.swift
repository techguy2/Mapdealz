//
//  ViewController.swift
//  DollaDollaBillsYall
//
//  Created by Soeb on 2/20/17.
//  Copyright © 2017 soeb. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
    var ballAnimator:UIViewPropertyAnimator!
    var viewCenter:CGPoint!
    let slideAnimation = AnimationHandler()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        slideAnimation.sourceController = self
        self.transitioningDelegate = slideAnimation
        view.backgroundColor = .white
//        let gesture = UIScreenEdgePanGestureRecognizer(target: slideAnimation , action: #selector(slideAnimation.pan(_:)))
//        let dragGesture = UIPanGestureRecognizer(target: self , action: #selector(drag))
//        gesture.edges = .right
//        view.addGestureRecognizer(gesture)
//        view.addGestureRecognizer(dragGesture)
//        dragGesture.delegate = self
        initiateBallView()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    let reverbtn: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Reverse", for: .normal)
        button.backgroundColor = .lightGray
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(handleReverse), for: .touchUpInside)
        button.isUserInteractionEnabled = true
        return button
    }()
    
    func handleReverse () {
            let customerController = FinalViewController()
            customerController.view.backgroundColor = .red
            customerController.slideAnimation = self.slideAnimation
            customerController.transitioningDelegate = slideAnimation
            self.slideAnimation.finalController = customerController
            customerController.modalPresentationStyle = .custom
            present(customerController, animated: true, completion: nil)
    }
    
    func initiateBallView () {
        
        let ballViewInitialFrame = CGRect(x: 0 , y: view.frame.height - 80, width: 50 , height: 50)
        let ballView = AnimationView(frame: ballViewInitialFrame)

        view.addSubview(ballView)
        print(view.isUserInteractionEnabled)
        ballAnimator = UIViewPropertyAnimator(duration: 1, curve: .linear)
        view.addSubview(reverbtn)

        
        reverbtn.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        reverbtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        reverbtn.widthAnchor.constraint(equalToConstant: 90).isActive = true
        reverbtn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        ballView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(ViewController.handleMovement)))
        
    }
    
    func handleMovement (recognizer: UIPanGestureRecognizer) {
        
        switch recognizer.state {
        case .began: break
            
        case .ended:
            ballAnimator.startAnimation()
        case .changed :
            let translation = recognizer.translation(in: self.view)

            ballAnimator.addAnimations {
                recognizer.view?.center = CGPoint(x: (recognizer.view?.center.x)! + translation.x, y: (recognizer.view?.center.y)! + translation.y)
            }
            recognizer.setTranslation(.zero, in: self.view)
            
          default:   break
        }
    }



}

