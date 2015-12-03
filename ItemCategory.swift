//
//  ItemCategory.swift
//  Merchant_Test
//
//  Created by FAWN on 15/12/2.
//  Copyright © 2015年 Talace. All rights reserved.
//

import Foundation
import Parse

class ItemCategory : MerchantBaseModel{

    var name: String!
    var store: Store!
    
    override init(pfObj: PFObject) {
        super.init(pfObj: pfObj)
        self.name = pfObj["name"] as! String
        self.store = Store.init(pfObj: pfObj["store"] as! PFObject)
    }
    
//    init(objectId: String!, name: String!, createdAt: NSDate!, updatedAt: NSDate!, acl: PFACL!){
//    
//        self.itemCategoryId = objectId
//        self.name = name
//        self.createdAt = createdAt
//        self.updatedAt = updatedAt
//        self.ACL = acl
//    
//    }


}
