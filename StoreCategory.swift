//
//  StoreCategory.swift
//  Merchant_Test
//
//  Created by FAWN on 15/12/2.
//  Copyright © 2015年 Talace. All rights reserved.
//

import Foundation
import Parse

class StoreCategory : PFObject, PFSubclassing{

    override class func initialize(){
        
        struct Static {
            
            static var onceToken : dispatch_once_t = 0;
        }
        dispatch_once(&Static.onceToken){
            
            self.registerSubclass()
        }
        
    }
    static func parseClassName() -> String {
        return "StoreCategory"
    }
    
    @NSManaged var name: String!
    
//    override init(pfObj: PFObject){
//    
//        super.init(pfObj: pfObj)
//    
//        self.name = pfObj["name"] as! String
//        
//    }
    
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
