//
//  Order.swift
//  Merchant_Test
//
//  Created by FAWN on 15/11/2.
//  Copyright © 2015年 Talace. All rights reserved.
//

import UIKit
import Parse


class Order : PFObject, PFSubclassing{
    
    override class func initialize(){
        
        struct Static {
            
            static var onceToken : dispatch_once_t = 0;
        }
        dispatch_once(&Static.onceToken){
            
            self.registerSubclass()
        }
        
    }
    static func parseClassName() -> String {
        return "Order"
    }
    
    @NSManaged var status: String
    @NSManaged var user: PFUser!
    @NSManaged var item: Item!
    @NSManaged var table: String

}
