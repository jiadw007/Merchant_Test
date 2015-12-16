//
//  Product.swift
//  Merchant_Test
//
//  Created by FAWN on 15/11/3.
//  Copyright © 2015年 Talace. All rights reserved.
//

import UIKit
import Parse
class Item : PFObject, PFSubclassing{
    
    
    override class func initialize(){
        
        struct Static {
            
            static var onceToken : dispatch_once_t = 0;
        }
        dispatch_once(&Static.onceToken){
            
            self.registerSubclass()
        }
        
    }
    static func parseClassName() -> String {
        return "Item"
    }
    
    @NSManaged var name : String!
    @NSManaged var summary : String!
    @NSManaged var price: Double
    @NSManaged var isActive : Bool
    @NSManaged var store : Store!
    @NSManaged var category : ItemCategory!
    @NSManaged var discount: Double
    func updateItem(){
    
        let query = PFQuery(className: "Item")
        query.getObjectInBackgroundWithId(self.objectId!){(itemObject: PFObject?, error: NSError?) -> Void in
            
            if error != nil{
                //TODO: Show error
                
            }else if let itemObject = itemObject{
                
                itemObject["name"] = self.name
                itemObject["summary"] = self.summary
                itemObject["price"] = self.price
                itemObject["discount"] = self.discount
                itemObject.saveInBackground()
                
            }
            
        }
    
    }
    
    
    
//    override init(pfObj: PFObject) {
//        super.init(pfObj: pfObj)
//        
//        self.name = pfObj["name"] as! String
//        self.description = pfObj["description"] as! String
//        self.price = pfObj["price"] as! Double
//        self.isActive = pfObj["isActive"] as! Bool
//        self.store = Store.init(pfObj: pfObj["store"] as! PFObject)
//        self.category = ItemCategory.init(pfObj: pfObj["category"] as! PFObject)
//    }
    
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