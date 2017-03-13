//
//  MenuStockTableViewCell.swift
//  MasterBeeTestVersion
//
//  Created by Shayin Feng on 3/10/17.
//  Copyright © 2017 Shayin Feng. All rights reserved.
//

import UIKit
import AFNetworking

class MenuStockTableViewCell: UITableViewCell {
    
    @IBOutlet weak var stockImageView: UIImageView!
    
    @IBOutlet weak var stockNameLabel: UILabel!
    
    @IBOutlet weak var plusButton: UIButton!
    
    @IBOutlet weak var backgroundCardView: UIView!
    
    @IBOutlet weak var quantityTag: UIButton!
    
    @IBOutlet weak var priceTag: UIButton!
    
    @IBOutlet weak var countInCartButton: UIButton!
    
    var stock: StockModel! {
        didSet {
            updateMenuStockCell ()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Card view setup
        
        backgroundCardView.layer.cornerRadius = 3.0
        backgroundCardView.layer.masksToBounds = false
        backgroundCardView.layer.shadowColor = UIColor.black.withAlphaComponent(0.3).cgColor
        backgroundCardView.layer.shadowOffset = CGSize(width: 0, height: 0)
        backgroundCardView.layer.shadowOpacity = 0.8
        
        plusButton.layer.cornerRadius = 3
        plusButton.layer.masksToBounds = true
        plusButton.layer.shadowColor = UIColor.black.withAlphaComponent(0.5).cgColor
        plusButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        plusButton.layer.shadowOpacity = 0.5
        
        quantityTag.layer.shadowColor = UIColor.black.withAlphaComponent(0.5).cgColor
        quantityTag.layer.shadowOffset = CGSize(width: 0, height: 0)
        quantityTag.layer.shadowOpacity = 0.5
        priceTag.layer.shadowColor = UIColor.black.withAlphaComponent(0.5).cgColor
        priceTag.layer.shadowOffset = CGSize(width: 0, height: 0)
        priceTag.layer.shadowOpacity = 0.5
        
        countInCartButton.isHidden = true
        
    }
    
    override func prepareForReuse() {
        stockImageView.image = nil
        countInCartButton.isHidden = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        //print(stock.dictionary)
    }
    
    private func updateMenuStockCell () {
        
        // Cache image
        if let images = stock.images, images != [] {
            if let imageURL = images[0].image_url_xxl {
                stockImageView.setImageWith(URLRequest(url: imageURL), placeholderImage: nil, success: { (request, response, image) in
                    self.stockImageView.image = image
                }, failure: { (request, response, error) in
                    print("Stock Cell Image Load Failed: \(error.localizedDescription)")
                })
            }
        } else {
            stockImageView.image = #imageLiteral(resourceName: "placeholder-image")
            print("NO IMAGE")
        }
        
        stockNameLabel.text = stock.name
        
        if let quantity = stock.left_quantity {
            quantityTag.setTitle("\(quantity) Left", for: .normal)
        } else {
            quantityTag.setTitle("0 Left", for: .normal)
            print("MenuStockCell: left_quantity is nil")
        }
        
        if let price = stock.price {
            priceTag.setTitle("$ \(price)", for: .normal)
        } else {
            priceTag.setTitle("No Price", for: .normal)
            print("MenuStockCell: price is nil")
        }
        
        countInCartButton.setTitle(String(stock.countInCart), for: .normal)
        if stock.countInCart > 0 {
            countInCartButton.isHidden = false
        }
    }
    
    @IBAction func countInCartButtonTapped(_ sender: UIButton) {
        stock.countInCart -= 1
        countInCartButton.setTitle(String(stock.countInCart), for: .normal)
        if stock.countInCart <= 0 {
            countInCartButton.isHidden = true
        }
    }
    
    @IBAction func plusButtonTapped(_ sender: UIButton) {
        stock.countInCart += 1
        countInCartButton.setTitle(String(stock.countInCart), for: .normal)
        if stock.countInCart > 0 {
            countInCartButton.isHidden = false
        }
    }
    
}
