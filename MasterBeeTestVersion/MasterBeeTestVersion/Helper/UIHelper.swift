//
//  UIHelper.swift
//  MasterBeeTestVersion
//
//  Created by Shayin Feng on 3/8/17.
//  Copyright © 2017 Shayin Feng. All rights reserved.
//

import UIKit

extension UIColor {
    static let mbYellow = UIColor(red: 0.98, green: 0.75, blue: 0.17, alpha: 1.0)
}

/** Mark: Slide in a UIView (Used in login view controller as action indicator) */

extension UIView {
    // Name this function in a way that makes sense to you...
    // slideFromLeft, slideRight, slideLeftToRight, etc. are great alternative names
    func slideInFromLeft(duration: TimeInterval = 1.0, completionDelegate: AnyObject? = nil) {
        // Create a CATransition animation
        let slideInFromLeftTransition = CATransition()
        
        // Set its callback delegate to the completionDelegate that was provided (if any)
        if let delegate: CAAnimationDelegate = completionDelegate as! CAAnimationDelegate? {
            slideInFromLeftTransition.delegate = delegate
        }
        
        // Customize the animation's properties
        slideInFromLeftTransition.type = kCATransitionPush
        slideInFromLeftTransition.subtype = kCATransitionFromLeft
        slideInFromLeftTransition.duration = duration
        slideInFromLeftTransition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        slideInFromLeftTransition.fillMode = kCAFillModeRemoved
        
        // Add the animation to the View's layer
        self.layer.add(slideInFromLeftTransition, forKey: "slideInFromLeftTransition")
    }
    
    /** Mark: Round assigned corners of UIView */
    
    func roundCorners(corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    func roundAllCorners(radius: CGFloat) {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = radius
    }
    
}

/// Mark: Return String of time difference, otherwise, formatted date.

/// ex: 2h, 5d

extension Date {
    
    // Returns the amount of days from another date
    func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
    // Returns the amount of hours from another date
    func hours(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }
    // Returns the amount of minutes from another date
    func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
    // Returns the amount of seconds from another date
    func seconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }
    // Returns the a custom time interval description from another date
    func offset(from date: Date) -> String {
        if days(from: date) > 6 {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "M/dd/yy"
            return dateFormatter.string(from: date)
        }
        if days(from: date) <= 6, days(from: date) > 0 {
            return "\(days(from: date))d"
        }
        if days(from: date) <= 0, hours(from: date) > 0 {
            return "\(hours(from: date))h"
        }
        if hours(from: date) <= 0, minutes(from: date) > 0 {
            return "\(minutes(from: date))m"
        }
        if minutes(from: date) <= 0, seconds(from: date) > 0 {
            return "\(seconds(from: date))s"
        }
        return "0s"
    }
    
    func dateToString (type: Int) -> String {
        let dateFormatter = DateFormatter()
        
        switch type {
        case 0:
            // 1.12.17
            dateFormatter.dateFormat = "d.M.yy"
        case 1:
            // 3/10/17
            dateFormatter.dateFormat = "M/dd/yy"
        case 2:
            // 03/10/2017
            dateFormatter.dateFormat = "MM/dd/yyyy"
        case 3:
            // 03-10-2017 22:34
            dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
        case 4:
            // Mar 10, 2017
            dateFormatter.dateFormat = "MMM d, yyyy"
        case 5:
            // Friday, Mar 10, 2017
            dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
        default:
            return ""
        }
        return dateFormatter.string(from: self)
    }
    
}

class UIHelper: NSObject {

}
