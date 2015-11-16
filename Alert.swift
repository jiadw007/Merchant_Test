//
//  Alert.swift
//  Merchant_Test
//
//  Created by FAWN on 15/11/2.
//  Copyright © 2015年 Talace. All rights reserved.
//

import Foundation

class Alert{

    var alertImage: String!
    
    var alertTime: String!
    
    var tableNo: String!
    
    var customerName: String!
    
    init(alertImage: String!, alertTime: String!, tableNo: String!, customerName: String!){
    
        self.alertImage = alertImage
        self.alertTime = alertTime
        self.tableNo = tableNo
        self.customerName = customerName
    }



}
