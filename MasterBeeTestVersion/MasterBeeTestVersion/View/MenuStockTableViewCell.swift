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
    
    @IBOutlet weak var countInCartLabel: UILabel!
    
    @IBOutlet weak var minusButton: UIButton!
    
    @IBOutlet weak var plusButton: UIButton!
    
    @IBOutlet weak var backgroundCardView: UIView!
    
    @IBOutlet weak var buttonBackgroundView: UIView!
    
    @IBOutlet weak var quantityTag: UIButton!
    
    @IBOutlet weak var priceTag: UIButton!
    
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
        
        buttonBackgroundView.layer.cornerRadius = 5
        buttonBackgroundView.layer.masksToBounds = true
        buttonBackgroundView.layer.borderColor = UIColor.mbYellow.cgColor
        buttonBackgroundView.layer.borderWidth = 1
        
        quantityTag.layer.shadowColor = UIColor.black.withAlphaComponent(0.5).cgColor
        quantityTag.layer.shadowOffset = CGSize(width: 0, height: 0)
        quantityTag.layer.shadowOpacity = 0.5
        priceTag.layer.shadowColor = UIColor.black.withAlphaComponent(0.5).cgColor
        priceTag.layer.shadowOffset = CGSize(width: 0, height: 0)
        priceTag.layer.shadowOpacity = 0.5

    }
    
    override func prepareForReuse() {
        stockImageView.image = nil
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        //print(stock.dictionary)
    }
    
    private func updateMenuStockCell () {
        
        // Cache image
        if let imageURL = stock.images?[0].image_url_xxl {
            stockImageView.setImageWith(URLRequest(url: imageURL), placeholderImage: nil, success: { (request, response, image) in
                self.stockImageView.image = image
            }, failure: { (request, response, error) in
                print("Stock Cell Image Load Failed: \(error.localizedDescription)")
            })
        } else {
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

    }
    
    @IBAction func minusButtonTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func plusButtonTapped(_ sender: UIButton) {
        
    }
    
}
