//
//  ItemCategory.swift
//  Merchant_Test
//
//  Created by FAWN on 15/12/2.
//  Copyright © 2015年 Talace. All rights reserved.
//

import Foundation
import Parse

class ItemCategory : PFObject, PFSubclassing{

    
    override class func initialize(){
    
        struct Static {
        
            static var onceToken : dispatch_once_t = 0;
        }
        dispatch_once(&Static.onceToken){
        
            self.registerSubclass()
        }
        
    }
    static func parseClassName() -> String {
        return "ItemCategory"
    }
    
    @NSManaged var name: String!
    @NSManaged var store: Store!
    
}
