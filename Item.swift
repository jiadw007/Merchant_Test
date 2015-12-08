//
//  Product.swift
//  Merchant_Test
//
//  Created by FAWN on 15/11/3.
//  Copyright © 2015年 Talace. All rights reserved.
//

import UIKit
import Parse
class Item : MerchantBaseModel{
    
    
    var name: String! = ""
    var description: String! = ""
    var price: Double! = 0.0
    var isActive : Bool! = true
    var store : Store!
    var category : ItemCategory!
    
    override init(pfObj: PFObject) {
        super.init(pfObj: pfObj)
        
        self.name = pfObj["name"] as! String
        self.description = pfObj["description"] as! String
        self.price = pfObj["price"] as! Double
        self.isActive = pfObj["isActive"] as! Bool
        self.store = Store.init(pfObj: pfObj["store"] as! PFObject)
        self.category = ItemCategory.init(pfObj: pfObj["category"] as! PFObject)
    }
    
//    private func getFirstItemPic() -> {
//    
//    
//    
//    }
    
//    init(title: String!, description: String!, price: String!, categoryArray: [String], imageArray: [UIImage]){
//        
//        self.title = title
//        self.description = description
//        self.price = price
//        self.categoryArray = categoryArray
//        self.imageArray = imageArray
//    
//    
//    }
    
//    private func addOneCategory(category: ItemCategory!){
//    
//        self.categoryArray.append(category)
//    }
//    
//    private func addOnePic(image: UIImage!){
//    
//        self.imageArray.append(image!)
//    }



}