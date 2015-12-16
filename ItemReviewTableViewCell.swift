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
        self.starRating.backgroundColor = UIColor.whiteColor()
        self.starRating.starImage = UIImage(named: "star-template")
        self.starRating.starImage = self.starRating.starImage
        self.starRating.starHighlightedImage = UIImage(named: "star-highlighted-template")
        self.starRating.maxRating = 5;
        self.starRating.editable = false
        
        self.starRating.displayMode = UInt(EDStarRatingDisplayHalf)
        self.starRating.tintColor = UIColor.blueColor()
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
