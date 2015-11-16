//
//  Product.swift
//  Merchant_Test
//
//  Created by FAWN on 15/11/3.
//  Copyright © 2015年 Talace. All rights reserved.
//

import UIKit

class Product{

    var title: String!
    var description: String!
    var price: String!
    var originalPrice: String!
    var categoryArray = [String]()
    var imageArray = [UIImage]()
    var reviewArray = [Review]()
    var averReviewPoints : Double!
    
    init(title: String!, description: String!, price: String!, categoryArray: [String], imageArray: [UIImage]){
        
        self.title = title
        self.description = description
        self.price = price
        self.categoryArray = categoryArray
        self.imageArray = imageArray
    
    
    }
    
    private func addOneCategory(category: String!){
    
        self.categoryArray.append(category)
    }
    
    private func addOnePic(image: UIImage!){
    
        self.imageArray.append(image!)
    }



}