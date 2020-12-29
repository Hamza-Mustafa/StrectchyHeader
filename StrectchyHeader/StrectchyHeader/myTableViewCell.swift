//
//  myTableViewCell.swift
//  StrectchyHeader
//
//  Created by Hamza Mustafa on 29/12/2020.
//

import UIKit

class myTableViewCell: UITableViewCell {
    
    @IBOutlet weak var myImg: UIImageView!
    @IBOutlet weak var myTitle: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
