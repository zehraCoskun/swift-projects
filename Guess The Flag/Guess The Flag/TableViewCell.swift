//
//  TableViewCell.swift
//  Guess The Flag
//
//  Created by Zehra Coşkun on 10.05.2024.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet var countryNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       // countryNameLabel.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

