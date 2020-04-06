//
//  ColorCell.swift
//  Popup-tutorials
//
//  Created by Rakesh Kumar on 06/04/20.
//  Copyright © 2020 Rakesh Kumar. All rights reserved.
//

import UIKit

class ColorCell: UITableViewCell {
    
    @IBOutlet weak var lblColorName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

