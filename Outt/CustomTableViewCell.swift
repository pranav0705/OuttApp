//
//  CustomTableViewCell.swift
//  Outt
//
//  Created by Jenil Shah on 3/5/17.
//  Copyright © 2017 NerdAttack. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var txtView: UITextView!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    @IBOutlet var heightConstraint: NSLayoutConstraint!
    var isExpanded:Bool = false
        {
        didSet
        {
            if !isExpanded {
                self.heightConstraint.constant = 30.0
                
            } else {
                self.heightConstraint.constant = 91.0
            }
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
