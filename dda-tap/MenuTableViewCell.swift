//
//  MenuTableViewCell.swift
//  dda-tap
//
//  Created by Victor Sira on 2019-10-27.
//  Copyright © 2019 Code the Change. All rights reserved.
//

import UIKit

class MenuOption: UITableViewCell {
    
    // MARK: Properties
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
