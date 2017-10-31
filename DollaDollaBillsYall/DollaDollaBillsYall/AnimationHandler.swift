//
//  AnimationHandler.swift
//  DollaDollaBillsYall
//
//  Created by Soeb on 3/6/17.
//  Copyright © 2017 soeb. All rights reserved.
//

import UIKit

class AnimationHandler: NSObject,UIViewControllerTransitioningDelegate,UIViewControllerAnimatedTransitioning,UIViewControllerInteractiveTransitioning, UIGestureRecognizerDelegate{
    var animation:UIViewImplicitlyAnimating?
    var interactive = false
    var context: UIViewControllerContextTransitioning?
    var sourceController:ViewController?

    
    var finalController:FinalViewController?
    var panGesture: UIPanGestureRecognizer?
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let pc = PresentationController(presentedViewController: presented, presenting: presenting)
        return pc
    }

    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        print("Inside Interactive Dismissal")
        return nil
    }
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        print("Inside Dismissal")
        return nil
    }
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        print("INside Animating Delegate")
        return self
    }
    
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        print("Inside Interactive \(self.interactive)")
        return self.interactive ? self : nil
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }
    
    
    func interruptibleAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        if self.animation != nil {
            return self.animation!
        }
        self.panGesture = UIPanGestureRecognizer(target: self, action: #selector(drag(_:)))
        self.panGesture?.delegate = self
        let vc2 = transitionContext.viewController(forKey: .to)
        let container = transitionContext.containerView
        let r2end = transitionContext.finalFrame(for: vc2!)
        let v2 = transitionContext.view(forKey: .to)
        v2?.frame = r2end
        v2?.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        container.addSubview(v2!)
        
        let anim = UIViewPropertyAnimator(duration: 1, curve: .easeInOut) {
//                v1?.frame = r1end
                v2?.alpha = 0.5
                v2?.transform = .identity
            }
            self.animation = anim
         anim.addCompletion { (position) in
            if position == .end {
                transitionContext.finishInteractiveTransition()
                transitionContext.completeTransition(true)
            } else {
                transitionContext.cancelInteractiveTransition()
                transitionContext.completeTransition(false)
            }
        }
        return anim
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        animation = self.interruptibleAnimator(using: transitionContext)
        animation?.startAnimation()
    }
    
    func startInteractiveTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        self.context = transitionContext
        self.animation = self.interruptibleAnimator(using: transitionContext)
    }
    
    
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func pan(_ gesture: UIScreenEdgePanGestureRecognizer) {
        switch gesture.state {
        case .began:
            self.interactive = true
            sourceController?.handleReverse()
        case .changed:
            let v = gesture.view
            let delta = gesture.translation(in: v)
            let percent = abs(delta.x/(v?.bounds.size.width)!)
            self.animation?.fractionComplete = percent
            self.context?.updateInteractiveTransition(percent)
            
        case .ended:
            self.animation?.pauseAnimation()
            if (self.animation?.fractionComplete)! < CGFloat(0.5) {
                self.animation?.isReversed = true
                self.interactive = false
            }
                self.animation?.continueAnimation!(withTimingParameters: UICubicTimingParameters.init(animationCurve: .linear), durationFactor: 0.2)
        default: break
            
        }

    }
    
    func tap (_ gesture: UITapGestureRecognizer) {
        print("tapped")
    }
    
    func drag (_ gesture: UIPanGestureRecognizer) {
        print(context?.isInteractive)
        context?.pauseInteractiveTransition()
        self.interactive = true
        sourceController?.handleReverse()
        let mainV = gesture.view

        switch gesture.state {
        case .began:
            self.animation?.pauseAnimation()
            fallthrough
        case .changed:
            let delta = gesture.translation(in: mainV)
            var center = mainV?.center
            center?.x += delta.x
            center?.y += delta.y
            mainV?.center = center!
            gesture.setTranslation(.zero, in: mainV?.superview)
        case .ended:
            let context = self.context
            let vc2 = context?.viewController(forKey: .to)
            self.animation?.addAnimations! {
                mainV?.frame = (context?.finalFrame(for: vc2!))!
            }
            let factor = 1 - (animation?.fractionComplete)!
            self.animation?.continueAnimation!(withTimingParameters: nil, durationFactor: factor)
        default: break
        }
    }
    
    func animationEnded(_ transitionCompleted: Bool) {
        self.interactive = false
        self.context = nil
        self.animation = nil
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
