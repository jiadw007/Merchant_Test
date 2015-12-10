//
//  ReviewTableViewCell.swift
//  Merchant_Test
//
//  Created by FAWN on 15/11/9.
//  Copyright © 2015年 Talace. All rights reserved.
//

import UIKit
import EDStarRating

class ItemReviewTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var userImage: UIImageView!

    @IBOutlet weak var reviewTitle: UILabel!
    
    @IBOutlet weak var reviewDetails: UILabel!
    
    @IBOutlet weak var reviewPoints: UILabel!
    
    @IBOutlet weak var starRating: EDStarRating!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
