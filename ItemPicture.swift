//
//  ItemPicture.swift
//  Merchant_Test
//
//  Created by FAWN on 15/12/2.
//  Copyright © 2015年 Talace. All rights reserved.
//

import Foundation
import Parse

class ItemPicture : MerchantBaseModel{
    

    var picture: PFFile!
    var item: Item!
    override init(pfObj: PFObject){
        
        super.init(pfObj: pfObj)
        self.picture = pfObj["picture"] as! PFFile
        self.item = Item.init(pfObj: pfObj["item"] as! PFObject)
    }
//    init(itemPictureId: String!, picture: PFFile!, createdAt: NSDate!, updatedAt: NSDate!, acl : PFACL!){
//    
//        self.itemPictureId = itemPictureId
//        self.picture = picture
//        self.createdAt = createdAt
//        self.updatedAt = updatedAt
//        self.ACL = acl
//    
//    
//    }
    


}
