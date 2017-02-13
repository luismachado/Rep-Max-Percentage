//
//  WeightTableViewCell.swift
//  RepMax Percentage
//
//  Created by Luís Machado on 30/09/16.
//  Copyright © 2016 LuisMachado. All rights reserved.
//

import UIKit

class WeightTableViewCell: UITableViewCell {

    @IBOutlet var percentageLabel: UILabel!
    @IBOutlet var weightLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
