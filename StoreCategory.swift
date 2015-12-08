//
//  StoreCategory.swift
//  Merchant_Test
//
//  Created by FAWN on 15/12/2.
//  Copyright © 2015年 Talace. All rights reserved.
//

import Foundation
import Parse

class StoreCategory : MerchantBaseModel{

    var name: String!
    
    override init(pfObj: PFObject){
    
        super.init(pfObj: pfObj)
    
        self.name = pfObj["name"] as! String
        
    }
    
//    init(storeCategoryId: String!, name: String!, createdAt: NSDate!, updatedAt: NSDate!, ACL: PFACL!){
//    
//        self.storeCategoryId = storeCategoryId
//        self.name = name
//        self.createdAt = createdAt
//        self.updatedAt = updatedAt
//        self.ACL = ACL
//    
//    }
    




}
