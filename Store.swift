//
//  Store.swift
//  Merchant_Test
//
//  Created by FAWN on 15/11/4.
//  Copyright © 2015年 Talace. All rights reserved.
//

import Foundation
import Parse



class Store: PFObject, PFSubclassing{


    override class func initialize(){
    
        struct Static {
        
            static var onceToken: dispatch_once_t = 0
        }
        dispatch_once(&Static.onceToken){
        
            self.registerSubclass()
        }
    }
    static func parseClassName() -> String {
        return "Store"
    }
    
    @NSManaged var name: String!
    @NSManaged var owner: PFUser!
    @NSManaged var phoneNumber: String!
    @NSManaged var summary: String
    @NSManaged var isActive: Bool
    @NSManaged var storeCategory: StoreCategory!
    @NSManaged var cover: PFFile!
    @NSManaged var logo: PFFile!
    
    func getStoreLogo() -> UIImage?{
    
        var error:NSError? = nil
        do{
            
            let image = UIImage(data: try self.logo.getData())
            
            return image
        }catch let error1 as NSError {
            error = error1
        }
        if (error != nil) {
            print("\(error?.localizedDescription)")
        }
        
        return nil
    }

}

//class Store : MerchantBaseModel{
//
//    
//    var storeCategory: StoreCategory!
//    var cover: PFFile!
//    var description: String!
//    var isActive: Bool!
//    var logo: PFFile!
//    var name: String!
//    var owner: PFUser!
//    var phoneNumber: String!
//    
//    override init(pfObj: PFObject) {
//        super.init(pfObj: pfObj)
//
//        self.storeCategory = StoreCategory.init(pfObj: pfObj["category"] as! PFObject)
//        self.cover = pfObj["cover"] as! PFFile
//        self.isActive = pfObj["isActive"] as! Bool
//        self.logo = pfObj["logo"] as! PFFile
//        self.name = pfObj["name"] as! String
//        self.phoneNumber = pfObj["phoneNumber"] as! String
//    
////        self.owner = PFUser
//    }
//    
//    
//    
//}