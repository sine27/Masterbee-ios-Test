//
//  OtherHelper.swift
//  MasterBeeTestVersion
//
//  Created by Shayin Feng on 3/11/17.
//  Copyright © 2017 Shayin Feng. All rights reserved.
//

import UIKit

class OtherHelper: NSObject {
    
    class func alertMessage(_ userTitle: String, userMessage: String, action: ((UIAlertAction) -> Void)?, sender: AnyObject)
    {
        let myAlert = UIAlertController(title: userTitle, message: userMessage, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: action)
        myAlert.addAction(okAction)
        sender.present(myAlert, animated: true, completion: nil)
    }
    
    class func alertMessageWithAction(_ userTitle: String, userMessage: String, left: String, right: String, leftAction: ((UIAlertAction) -> Void)?, rightAction: ((UIAlertAction) -> Void)?, sender: AnyObject)
    {
        let myAlert = UIAlertController(title: userTitle, message: userMessage, preferredStyle: UIAlertControllerStyle.alert)
        
        myAlert.addAction(UIAlertAction(title: left, style: .cancel, handler: leftAction))
        
        myAlert.addAction(UIAlertAction(title: right, style: .destructive, handler: rightAction))
        sender.present(myAlert, animated: true, completion: nil)
    }
}
