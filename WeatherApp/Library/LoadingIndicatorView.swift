//
//  LoadingIndicatorView
//
//  Created by Nilesh Patel on 16/02/17
//  Copyright (c) Copyright © 2017 MIT Agency. All rights reserved.
//

import UIKit

public enum LoadingIndicatorPosition {
    case Top
    case Center
    case Bottom
}

class LoadingIndicatorView {
    
    static var currentOverlay : UIView?
    
    static func show() {
        guard let currentMainWindow = UIApplication.shared.keyWindow else {
            print("No main window.")
            return
        }
        show(overlayTarget: currentMainWindow)
    }
    
    static func show(loadingText: String) {
        guard let currentMainWindow = UIApplication.shared.keyWindow else {
            print("No main window.")
            return
        }
        show(overlayTarget: currentMainWindow, loadingText: loadingText)
    }
    
    static func show(overlayTarget : UIView) {
        show(overlayTarget: overlayTarget, loadingText: nil)
    }
    
    static func show(overlayTarget : UIView, loadingText: String?,
                     position: LoadingIndicatorPosition = .Center, overlayColor: UIColor = UIColor.clear) {
        // Clear it first in case it was already shown
        for view in overlayTarget.subviews {
            if view.tag == 200 {
                // Subview exists
                hide()
            }
        }
        
        debugPrint(#function, overlayTarget.frame)
        
        // Create the overlay
        let overlay = UIView(frame: overlayTarget.frame)
        overlay.tag = 200
        overlay.center = overlayTarget.center
        overlay.alpha = 0
        overlay.backgroundColor = overlayColor
        overlayTarget.addSubview(overlay)
        overlayTarget.bringSubview(toFront: overlay)
        
        currentOverlay = overlay
        
        // Create and animate the activity indicator
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        indicator.center = centerPointForPosition(position: position, activity: indicator, targetView: currentOverlay!)
        indicator.tag = 100
        indicator.startAnimating()
        overlay.addSubview(indicator)
        
        // Create label to display below the activity indicator.
        if let textString = loadingText {
            let label = UILabel()
            label.text = textString
            label.textColor = UIColor.white
            label.sizeToFit()
            label.tag = 101
            label.center = CGPoint(x: indicator.center.x, y: indicator.center.y + 30)
            overlay.addSubview(label)
        }
        
        // Animate the overlay to show
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.5)
        overlay.backgroundColor = overlayColor
        overlay.alpha = overlay.alpha > 0 ? 0 : 1.0
        UIView.commitAnimations()
    }
    
    static var activityIndicatorView: UIActivityIndicatorView? {
        return self.currentOverlay?.viewWithTag(100) as? UIActivityIndicatorView
    }
    
    static var labelFromOverlay: UILabel? {
        return currentOverlay?.viewWithTag(101) as? UILabel
    }
    
    static func hide() {
        if currentOverlay != nil {
            currentOverlay?.removeFromSuperview()
            currentOverlay =  nil
        }
    }
    
    static func hideAnimated(animated: Bool) {
        if !animated {
            self.hide()
            return
        }
        UIView.animate(withDuration: 0.3, animations: { 
            currentOverlay?.alpha = 0.0
            }) { (finished) in
                self.hide()
        }
    }
    
    static func centerPointForPosition(position: LoadingIndicatorPosition, activity: UIView, targetView: UIView) -> CGPoint {
        let padding: CGFloat = 10
        
        switch(position) {
        case .Top:
            return CGPoint(x: targetView.bounds.size.width / 2.0, y: (activity.frame.size.height / 2.0) + padding)
        case .Center:
            return CGPoint(x: targetView.bounds.size.width / 2.0, y: targetView.bounds.size.height / 2.0)
        case .Bottom:
            return CGPoint(x: targetView.bounds.size.width / 2.0, y: (targetView.bounds.size.height - (activity.frame.size.height / 2.0)) - padding)
        }
    }
}
