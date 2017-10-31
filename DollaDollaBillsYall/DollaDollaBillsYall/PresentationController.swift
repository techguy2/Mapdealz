//
//  PresentationController.swift
//  DollaDollaBillsYall
//
//  Created by Soeb on 3/7/17.
//  Copyright © 2017 soeb. All rights reserved.
//

import UIKit

class PresentationController: UIPresentationController {
    
    override var shouldRemovePresentersView: Bool {
        return false
    }
    
//    override var frameOfPresentedViewInContainerView: CGRect {
//        return super.frameOfPresentedViewInContainerView.insetBy(dx: 40, dy: 40)
//    }

    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        print("Inside Property Controller")
    }
    
    
}
