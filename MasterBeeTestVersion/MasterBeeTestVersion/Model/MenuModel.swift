//
//  MenuModel.swift
//  MasterBeeTestVersion
//
//  Created by Shayin Feng on 3/11/17.
//  Copyright © 2017 Shayin Feng. All rights reserved.
//

import UIKit

/**
 "id": 30,
 "name": "Top",
 "locale": "en"
 */

class MenuModel: NSObject {
    
    var id: Int!
    var name: String!
    var dictionary: NSDictionary!
    
    var stocks: [StockModel] = []
    
    var locale: String?
    
    init(dictionary: NSDictionary) {
        
        self.dictionary = dictionary
        
        if let id = dictionary["id"] as? Int {
            self.id = id
        } else {
            self.id = -1
            print("[MenuModel] Error: nil id")
        }
        
        if let name = dictionary["name"] as? String {
            self.name = name
        } else {
            self.name = "NO NAME"
            print("[MenuModel] Error: nil name")
        }
        
        if let locale = dictionary["locale"] as? String {
            self.locale = locale
        } else {
            print("[MenuModel] Error: nil locale")
        }
    }
}
