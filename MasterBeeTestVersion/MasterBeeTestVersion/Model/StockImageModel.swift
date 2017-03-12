//
//  StockImageModel.swift
//  MasterBeeTestVersion
//
//  Created by Shayin Feng on 3/11/17.
//  Copyright © 2017 Shayin Feng. All rights reserved.
//

import UIKit

/**
 {
 "locale": "en",
 "image_type": "Menu",
 "updated_at": "2017-03-06T15:13:14.796-05:00",
 "image_url_original": "http://s3.amazonaws.com/mb-op-prod-r1/production/images/333/image/original/1488831194.jpg?1488831194",
 "image_url_xxl": "http://s3.amazonaws.com/mb-op-prod-r1/production/images/333/image/xxl/1488831194.jpg?1488831194",
 "image_url_xl": "http://s3.amazonaws.com/mb-op-prod-r1/production/images/333/image/xl/1488831194.jpg?1488831194",
 "image_url_l": "http://s3.amazonaws.com/mb-op-prod-r1/production/images/333/image/l/1488831194.jpg?1488831194",
 "image_url_m": "http://s3.amazonaws.com/mb-op-prod-r1/production/images/333/image/m/1488831194.jpg?1488831194",
 "image_url_s": "http://s3.amazonaws.com/mb-op-prod-r1/production/images/333/image/s/1488831194.jpg?1488831194"
 }
 */

class StockImageModel: NSObject {
    
    var dictionary: NSDictionary!
    
    var locale: String?
    var image_type: String?
    var updated_at: Date?
    var image_url_original: URL?
    var image_url_xxl: URL?
    var image_url_xl: URL?
    var image_url_l: URL?
    var image_url_m: URL?
    var image_url_s: URL?
    
    init(dictionary: NSDictionary) {
        
        self.dictionary = dictionary
        
        if let locale = dictionary["locale"] as? String {
            self.locale = locale
        } else {
            print("[StockImageModel] Error: nil locale")
        }
        
        if let image_type = dictionary["image_type"] as? String {
            self.image_type = image_type
        } else {
            print("[StockImageModel] Error: nil image_type")
        }
        
        if let updated_at_string = dictionary["updated_at"] as? String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            self.updated_at = dateFormatter.date(from: updated_at_string)
        } else {
            print("[StockImageModel] Error: nil locale")
        }
        
        if let image_url_original_string = dictionary["image_url_original"] as? String {
            self.image_url_original = URL(string: image_url_original_string)
        } else {
            print("[StockImageModel] Error: nil image_url_original")
        }
        
        if let image_url_xxl_string = dictionary["image_url_xxl"] as? String {
            self.image_url_xxl = URL(string: image_url_xxl_string)
        } else {
            print("[StockImageModel] Error: nil image_url_xxl")
        }
        
        if let image_url_xl_string = dictionary["image_url_xl"] as? String {
            self.image_url_xl = URL(string: image_url_xl_string)
        } else {
            print("[StockImageModel] Error: nil image_url_xl")
        }
        
        if let image_url_l_string = dictionary["image_url_l"] as? String {
            self.image_url_l = URL(string: image_url_l_string)
        } else {
            print("[StockImageModel] Error: nil image_url_l")
        }
        
        if let image_url_m_string = dictionary["image_url_m"] as? String {
            self.image_url_m = URL(string: image_url_m_string)
        } else {
            print("[StockImageModel] Error: nil image_url_m")
        }
        
        if let image_url_s_string = dictionary["image_url_s"] as? String {
            self.image_url_s = URL(string: image_url_s_string)
        } else {
            print("[StockImageModel] Error: nil image_url_s")
        }
    }
}
