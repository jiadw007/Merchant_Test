//
//  Review.swift
//  Merchant_Test
//
//  Created by FAWN on 15/11/4.
//  Copyright © 2015年 Talace. All rights reserved.
//

import Foundation
import Parse

class ItemReview : MerchantBaseModel{

    var content: String!
    var rating: Float!
    var item: Item!
    var user: PFUser!
    
    override init(pfObj: PFObject) {
        super.init(pfObj: pfObj)
        self.content = pfObj["content"] as! String
        self.rating = pfObj["rating"] as! Float
        self.item = Item.init(pfObj: pfObj["item"] as! PFObject)
        self.user = pfObj["user"] as! PFUser
    }
    
}