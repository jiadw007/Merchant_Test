//
//  ItemPicture.swift
//  Merchant_Test
//
//  Created by FAWN on 15/12/2.
//  Copyright © 2015年 Talace. All rights reserved.
//

import Foundation
import Parse

class ItemPicture : PFObject, PFSubclassing{
    
    
    override class func initialize(){
        
        struct Static {
            
            static var onceToken : dispatch_once_t = 0;
        }
        dispatch_once(&Static.onceToken){
            
            self.registerSubclass()
        }
        
    }
    static func parseClassName() -> String {
        return "ItemPicture"
    }
    
    @NSManaged var picture: PFFile!
    @NSManaged var item: Item!
    
//    override init(pfObj: PFObject){
//        
//        super.init(pfObj: pfObj)
//        self.picture = pfObj["picture"] as! PFFile
//        self.item = Item.init(pfObj: pfObj["item"] as! PFObject)
//    }
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
