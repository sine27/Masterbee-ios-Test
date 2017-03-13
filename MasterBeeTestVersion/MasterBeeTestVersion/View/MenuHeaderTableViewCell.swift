//
//  MenuHeaderTableViewCell.swift
//  MasterBeeTestVersion
//
//  Created by Shayin Feng on 3/12/17.
//  Copyright © 2017 Shayin Feng. All rights reserved.
//

import UIKit

class MenuHeaderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellLabel: UILabel!

    @IBOutlet weak var cellLabelRight: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
