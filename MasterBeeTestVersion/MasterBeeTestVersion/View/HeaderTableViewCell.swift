//
//  TimeSpanHeaderTableViewCell.swift
//  MasterBeeTestVersion
//
//  Created by Shayin Feng on 3/9/17.
//  Copyright © 2017 Shayin Feng. All rights reserved.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var cellLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        cellLabel.text = ""
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
