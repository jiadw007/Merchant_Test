//
//  Store.swift
//  Merchant_Test
//
//  Created by FAWN on 15/11/4.
//  Copyright © 2015年 Talace. All rights reserved.
//

import Foundation
import Parse

class Store : MerchantBaseModel{

    
    var storeCategory: StoreCategory!
    var cover: PFFile!
    var description: String!
    var isActive: Bool!
    var logo: PFFile!
    var name: String!
    var owner: PFUser!
    var phoneNumber: String!
    
    override init(pfObj: PFObject) {
        super.init(pfObj: pfObj)

        self.storeCategory = StoreCategory.init(pfObj: pfObj["category"] as! PFObject)
        self.cover = pfObj["cover"] as! PFFile
        self.isActive = pfObj["isActive"] as! Bool
        self.logo = pfObj["logo"] as! PFFile
        self.name = pfObj["name"] as! String
        self.phoneNumber = pfObj["phoneNumber"] as! String
    
//        self.owner = PFUser
    }
    
    
    
}