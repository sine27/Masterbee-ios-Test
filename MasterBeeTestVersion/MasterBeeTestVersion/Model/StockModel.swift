//
//  StockModel.swift
//  MasterBeeTestVersion
//
//  Created by Shayin Feng on 3/11/17.
//  Copyright © 2017 Shayin Feng. All rights reserved.
//
/**
{
    "name": "Cabbage braised in stock",
    "product_id": 201,
    "left_quantity": 20,
    "price": 4.99,
    "menus": [
    {
    "id": 30,
    "name": "Top",
    "locale": "en"
    }
    ],
    "images": [
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
    ],
    "temperature": "hot"
}
 */

import UIKit

class StockModel: NSObject {
    
    var dictionary: NSDictionary!
    
    var name: String!
    var product_id: Int!
    var left_quantity: Int!
    
    var price: Float?
    var menus: [MenuModel]?
    var images: [StockImageModel]?
    var temperature: String?
    
    /** extra vars from UI: table row index */
    var rowAt: IndexPath? /* IndexPath for MenuTable */
    var indexPathAt: IndexPath? /* IndexPath for ContentTable, it should be an array of IndexPath if a single product has multiple menus */
    var countInCart: Int = 0 /* count of orders put in cart */
    
    init(dictionary: NSDictionary) {
        
        self.dictionary = dictionary
        
        if let name = dictionary["name"] as? String {
            self.name = name
        } else {
            self.name = "NO NAME"
            print("[StockModel] Error: nil name")
        }
        
        if let product_id = dictionary["product_id"] as? Int {
            self.product_id = product_id
        } else {
            self.product_id = -1
            print("[StockModel] Error: nil product_id")
        }
        
        if let left_quantity = dictionary["left_quantity"] as? Int {
            self.left_quantity = left_quantity
        } else {
            self.left_quantity = 0
            print("[StockModel] Error: nil left_quantity")
        }
        
        if let price = dictionary["price"] as? Float {
            self.price = price
        } else {
            print("[StockModel] Error: nil price")
        }
        
        if let menus = dictionary["menus"] as? NSArray {
            var menuArray: [MenuModel] = []
            for menu in menus {
                menuArray.append(MenuModel(dictionary: menu as! NSDictionary))
            }
            self.menus = menuArray
        } else {
            print("[StockModel] Error: nil menus")
        }
        
        if let images = dictionary["images"] as? NSArray {
            var imageArray: [StockImageModel] = []
            for image in images {
                imageArray.append(StockImageModel(dictionary: image as! NSDictionary))
            }
            self.images = imageArray
        } else {
            print("[StockModel] Error: nil images")
        }
        
        if let temperature = dictionary["temperature"] as? String {
            self.temperature = temperature
        } else {
            print("[StockModel] Error: nil temperature")
        }
        
        self.countInCart = 0
    }
}
