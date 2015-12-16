//
//  Review.swift
//  Merchant_Test
//
//  Created by FAWN on 15/11/4.
//  Copyright © 2015年 Talace. All rights reserved.
//

import Foundation
import Parse

class ItemReview : PFObject, PFSubclassing{

    override class func initialize(){
        
        struct Static {
            
            static var onceToken : dispatch_once_t = 0;
        }
        dispatch_once(&Static.onceToken){
            
            self.registerSubclass()
        }
        
    }
    static func parseClassName() -> String {
        return "ItemReview"
    }
    
    @NSManaged var content: String!
    @NSManaged var rating: Float
    @NSManaged var item: Item!
    @NSManaged var user: PFUser!
    
    
    
}