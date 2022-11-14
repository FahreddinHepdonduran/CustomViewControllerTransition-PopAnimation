//
//  PopAnimator.swift
//  CustomTransitionDemo
//
//  Created by fahreddin on 13.11.2022.
//

import Foundation
import UIKit

class PopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    var duration: CGFloat = 0.8
    var presenting: Bool = true
    var originFrame: CGRect = .zero
    var dismissCompletion: (() -> Void)?

    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let toView = transitionContext.view(forKey: .to)!
        let detailView = presenting ? toView : transitionContext.view(forKey: .from)!
       
        let initialFrame = presenting ? originFrame : detailView.frame
        let finalFrame = presenting ? detailView.frame : originFrame
        
        let xScaleFactor = presenting ?
            initialFrame.width / finalFrame.width :
            finalFrame.width / initialFrame.width
        
        let yScaleFactor = presenting ?
            initialFrame.height / finalFrame.height :
            finalFrame.height / initialFrame.height
        
        let scaleTransform = CGAffineTransform(scaleX: xScaleFactor, y: yScaleFactor)
        
        if presenting {
          detailView.transform = scaleTransform
          detailView.center = CGPoint(
            x: initialFrame.midX,
            y: initialFrame.midY)
          detailView.clipsToBounds = true
        }
        
        detailView.layer.cornerRadius = presenting ? 20.0 : 0.0
        detailView.layer.masksToBounds = true
        
        containerView.addSubview(toView)
        containerView.bringSubviewToFront(detailView)
        
        UIView.animate(withDuration: duration, delay: 0.0,
                       usingSpringWithDamping: 0.5, initialSpringVelocity: 0.2) {
            detailView.transform = self.presenting ? .identity : scaleTransform
            detailView.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
            detailView.layer.cornerRadius = !self.presenting ? 20.0 : 0.0
        } completion: { _ in
            if !self.presenting {
                self.dismissCompletion?()
            }
            
            transitionContext.completeTransition(true)
        }

    }
    
}
