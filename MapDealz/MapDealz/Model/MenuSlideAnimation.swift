//
//  MenuSlideAnimation.swift
//  Mapdealz
//
//  Created by Soeb on 10/20/17.
//  Copyright © 2017 soeb. All rights reserved.
//

import Foundation
import UIKit

class MenuSlideAnimation: NSObject {
    var isPresenting = true
    var interacting = false
    var animator : UIViewImplicitlyAnimating?
    private var context : UIViewControllerContextTransitioning?
    
    
    
}

extension MenuSlideAnimation : UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
       self.interruptibleAnimator(using: transitionContext).startAnimation()
    }
    
    func interruptibleAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        if self.animator != nil {
            return self.animator!
        } else {
            self.context = transitionContext
            let container = context?.containerView
            let screen: (from:UIViewController, to:UIViewController) = (self.context!.viewController(forKey: .from)!,(self.context!.viewController(forKey: .to))!)
            let menuViewController = isPresenting ? screen.to : screen.from
            let topViewController = isPresenting ? screen.from: screen.to
            let menuView = menuViewController.view
            let topView = topViewController.view
            container?.insertSubview(menuView!, belowSubview: topView!)
            // Prepare Menu View Controller to Slide IN
            let snapshot = container?.viewWithTag(1234)
            
            let anim = UIViewPropertyAnimator (duration: 1, curve: .linear)
            if (isPresenting) {
                let snapshot = topView?.snapshotView(afterScreenUpdates: false)
                snapshot?.layer.shadowOpacity = 0.7
                snapshot?.isUserInteractionEnabled = false
                snapshot?.tag = 1234
                container?.insertSubview(snapshot!, aboveSubview: menuView!)
                topView?.isHidden = true
                anim.addAnimations {
                    snapshot?.transform = CGAffineTransform(translationX: (container?.frame.width)!/1.4, y: 0)
                    menuView?.transform = CGAffineTransform.identity
                }
            } else {
                container?.insertSubview(snapshot!, aboveSubview: menuView!)
                anim.addAnimations {
                    menuView?.transform = CGAffineTransform(translationX: -((container?.frame.width)!), y: 0)
                    snapshot?.transform = CGAffineTransform(translationX: 0, y: 0)
                }
                topView?.isHidden = false

            }

            anim.addCompletion({ (finish) in
                self.context?.completeTransition(true)

            })
            self.animator = anim
            return anim
        }

        
    }
    
    func animationEnded(_ transitionCompleted: Bool) {
        self.animator?.isReversed = true
        self.interacting = false
        self.animator = nil
        self.context = nil
    }
}

extension MenuSlideAnimation : UIViewControllerInteractiveTransitioning {
    
    
    func startInteractiveTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        self.context = transitionContext
        self.animator = self.interruptibleAnimator(using: transitionContext)
    }
    
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return self.interacting ? self : nil
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return self.interacting ? self : nil
    }
    
}




extension MenuSlideAnimation : UIViewControllerTransitioningDelegate {
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.isPresenting = false
        return self
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.isPresenting = true
        return self
    }
}

