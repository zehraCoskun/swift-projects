//
//  TableViewCell.swift
//  guess the flag
//
//  Created by Zehra Coşkun on 30.04.2024.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var countryNameLabel: UILabel!
    
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
