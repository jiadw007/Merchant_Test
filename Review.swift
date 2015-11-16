//
//  Review.swift
//  Merchant_Test
//
//  Created by FAWN on 15/11/4.
//  Copyright © 2015年 Talace. All rights reserved.
//

import Foundation

class Review {

    var reviewTitle: String!
    var reviewDetails: String!
    var points: Double! = 0.0
    
    init(title: String!, details: String!, points: Double!){
    
        
        self.reviewTitle = title
        self.reviewDetails = details
        self.points = points
    
    
    }
}