//
//  MerchantBaseModel.swift
//  Merchant_Test
//
//  Created by FAWN on 15/12/2.
//  Copyright © 2015年 Talace. All rights reserved.
//

import Foundation
import Parse

class MerchantBaseModel {

    let objectId : String!
    var createdAt : NSDate!
    var updatedAt : NSDate!
    //var ACL : PFACL!
    
    init(pfObj: PFObject){
    
        self.objectId = pfObj.objectId
        self.createdAt = pfObj.createdAt
        self.updatedAt = pfObj.updatedAt
        //self.ACL = pfObj.ACL
    
    
    }
    





}
