//
//  Order.swift
//  Merchant_Test
//
//  Created by FAWN on 15/11/2.
//  Copyright © 2015年 Talace. All rights reserved.
//

import UIKit
import Parse

class Order : MerchantBaseModel{

//    var orderNo : String!
//    
//    var orderTime: String!
//    
//    var customerName: String!
//    
//    var orderImage: UIImage!
//    
//    var orderDetails: String!
//    
//    var orderPrice: String!
//    
//    var tableNo: String!
//    
//    init(orderNo: String!, orderTime: String!, customerName: String!, orderImage: UIImage!, orderDetails: String!, orderPrice: String!, tableNo: String!){
//    
//        self.orderNo = orderNo
//        self.orderTime = orderTime
//        self.customerName = customerName
//        self.orderImage = orderImage
//        self.orderDetails = orderDetails
//        self.orderPrice = orderPrice
//        self.tableNo = tableNo
//        
//    }
    var status: String!
    var user: PFUser!
    var item: Item!
    
    override init(pfObj: PFObject) {
        super.init(pfObj: pfObj)
        self.status = pfObj["status"] as! String
        //self.user = PFUser
        self.item = Item.init(pfObj: pfObj["item"] as! PFObject)
    }
    

}
