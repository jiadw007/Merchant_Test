//
//  MerchnatDataService.swift
//  Merchant_Test
//
//  Created by FAWN on 15/12/2.
//  Copyright © 2015年 Talace. All rights reserved.
//

import Foundation
import Fabric
import Parse
import Stripe
import Crashlytics
import UIKit

class MerchantDataService {
    
    
    static var currentMerchant: PFUser? = nil
    static var currentStore: PFObject? = nil
    private struct Constants {
    
        static let ParseApplicationID = "by3yCcO7hzhPU5bys8MY1v9FRGtj0iReN3R7ZW2R"
        static let ParseClientKey = "VPzb9RsxNZjlf4XFJ2idLP6STI1AtTLEoU4vpkxy"
    
    }

    class func setEnv(){
    
        Parse.setApplicationId(Constants.ParseApplicationID, clientKey: Constants.ParseClientKey)
        //Stripe.setDefaultPublishableKey()
        //Fabric.with([Crashlytics()])
        
    }
    
    // Move to View Controller
    func merchantSignUp(username: String!, password: String!, email: String!) {
    
        let merchant = PFUser()
        merchant.username = username
        merchant.password = password
        merchant.email = email
        
        merchant.signUpInBackgroundWithBlock{
            (succeed: Bool, error: NSError?) -> Void in
            if let error = error {
                
                let errorString = error.userInfo["error"] as? String
            
            }else{
                // use the app now
            }
        
        }
    
    }
    // Move to View Controller
    class func merchantSignIn(username: String!, password: String!){
       
        //sync
        var error: NSError? = nil
        do{
            try PFUser.logInWithUsername(username, password: password)
            MerchantDataService.currentStore = MerchantDataService.findMerchantStore()
        }catch let error1 as NSError{
            error = error1
        }
        if error != nil{
            
            print("\(error?.localizedDescription)")
        }

        //async
//        PFUser.logInWithUsernameInBackground(username, password: password){
//        
//            (user: PFUser?, error: NSError?) -> Void in
//            if user != nil{
//            
//                print("Success")
//            }else{
//                
//                print("fail")
//                let errorString = error?.userInfo["error"] as? String
//                let alertView = UIAlertView(title: "Error", message: errorString, delegate: nil, cancelButtonTitle: "OK")
//                alertView.show()
//            }
//        
//        }
    
    }
    
    class func findMerchantStore() -> PFObject?{
        let merchant = PFUser.currentUser()
        let query = PFQuery(className: "Store")
        query.whereKey("owner", equalTo: merchant!)
        query.includeKey("category")
        // TODO: Find all stores for one merchant?
        let storeArray = MerchantDataService.queryAllObjects(query)
        if storeArray.count != 0 {
            return storeArray[0]
        }else{
            return nil
        }
    }
    
    class func queryAllObjects(query: PFQuery) -> [PFObject]{
        
        //Query
        var error: NSError? = nil
        do{
            let array = try query.findObjects()
            
            return array
        }catch let error1 as NSError{
            error = error1
        }
        if error != nil{
            
            print("\(error?.localizedDescription)")
        }
        return []
    }
    
    // - MARK: Item
    
    class func findAllItemsInStore() -> [PFObject]{
        
        if MerchantDataService.currentStore != nil{
        let query = PFQuery(className: "Item")
            query.whereKey("store", equalTo: MerchantDataService.currentStore!)
            query.includeKey("category.store.category")
            query.includeKey("store.category")
            // Find all items
            return MerchantDataService.queryAllObjects(query)
        }else{
        
            return []
        }
    
    }
    class func updateItemInStore(item: Item){
        
        var itemObject = PFObject(withoutDataWithClassName: "Item", objectId: item.objectId)
        itemObject["name"] = item.name
        itemObject["description"] = item.description
        itemObject["price"] = Double(item.price)
        itemObject["category"] = PFObject(withoutDataWithClassName: "ItemCategory", objectId: item.category.objectId)
        var error: NSError? = nil
        do{
            let success = try itemObject.save()
            
        }catch let error1 as NSError{
            error = error1
        }
        if error != nil{
            
            print("\(error?.localizedDescription)")
        }
    }
    class func reloadItem(item: Item) -> Item{
        
        let query = PFQuery(className: "Item")
        query.whereKey("objectId", equalTo: item.objectId)
        query.includeKey("category.store.category")
        query.includeKey("store.category")
        
        return Item.init(pfObj: MerchantDataService.queryAllObjects(query)[0])
        
    }
    
    class func addItemInStore(name: String?, description: String?, category: ItemCategory, price:String?, itemPictureArray:[UIImage] ){
        
        var itemObject = PFObject(className: "Item")
        itemObject["name"] = name!
        itemObject["description"] = description!
        itemObject["price"] = Double(price!)
        itemObject["category"] = PFObject(withoutDataWithClassName: "ItemCategory", objectId: category.objectId)
        itemObject["isActive"] = true
        itemObject["store"] = MerchantDataService.currentStore!
        print(itemObject.objectId)
        var error: NSError? = nil
        do{
            let success = try itemObject.save()
            //for image in itemPictureArray{
            
            MerchantDataService.addItemPictureWithItemId(itemObject.objectId!, itemPictureArray: itemPictureArray)
            
            //}
        }catch let error1 as NSError{
            error = error1
        }
        if error != nil{
            
            print("\(error?.localizedDescription)")
        }
        
        
    }
    
    
    
    // - MARK: Item Picture
    class func findAllItemPictureInItem(item: Item) -> [PFObject]{
    
        let itemPFObject = PFObject(withoutDataWithClassName: "Item", objectId: item.objectId)
        let query = PFQuery(className: "ItemPicture")
        query.whereKey("item", equalTo: itemPFObject)
        query.includeKey("item.category.store.category")
        query.includeKey("item.store.category")
        // Find all item picture
        return MerchantDataService.queryAllObjects(query)
    
    }
    
    class func addItemPictureWithItemId(id: String!, itemPictureArray:[UIImage]){
        
        let itemObject = PFObject(withoutDataWithClassName: "Item", objectId: id)
        
        for image in itemPictureArray{
            
            var itemPicture = PFObject(className: "ItemPicture")
            
            itemPicture["item"] = itemObject
            itemPicture["picture"] = PFFile(data: UIImageJPEGRepresentation(image, 0.5)!)
            
            var error: NSError? = nil
            do{
                let success = try itemPicture.save()
                //return array
            }catch let error1 as NSError{
                error = error1
            }
            if error != nil{
                
                print("\(error?.localizedDescription)")
            }
        }
        
    }
    
    class func addItemPictureWithItem(item: Item, itemImage: UIImage){
        
        let itemObject = PFObject(withoutDataWithClassName: "Item", objectId: item.objectId)
        
        var itemPicture = PFObject(className: "ItemPicture")
        
        itemPicture["item"] = itemObject
        itemPicture["picture"] = PFFile(data: UIImageJPEGRepresentation(itemImage, 0.5)!)
        
        var error: NSError? = nil
        do{
            let success = try itemPicture.save()
            //return array
        }catch let error1 as NSError{
            error = error1
        }
        if error != nil{
            
            print("\(error?.localizedDescription)")
        }
        
    }
    
    class func fetchImageFile(item: Item) -> PFFile?{
        
        let itemPictureArray = MerchantDataService.findAllItemPictureInItem(item)
        if itemPictureArray.count != 0{
            
            if let imageFile = itemPictureArray[0].valueForKey("picture") as? PFFile{
                
                return imageFile
            }
            
        }
        
        return nil
    }
    
    
    // - MARK: ItemCategory
    
    class func findAllItemCategoriesInStore() -> [PFObject] {
        
        if let currentStore = MerchantDataService.currentStore{
            let query = PFQuery(className: "ItemCategory")
            query.whereKey("store", equalTo: currentStore)
            query.includeKey("store.category")
            // Find all item categories
            return MerchantDataService.queryAllObjects(query)
        }
        return []
        
    }
    
    class func deleteItemCategoryInStore(itemCategory : ItemCategory){
    
        let itemCategoryObject = PFObject(withoutDataWithClassName: "ItemCategory", objectId: itemCategory.objectId)
        var error: NSError? = nil
        do{
            let success = try itemCategoryObject.delete()
            
        }catch let error1 as NSError{
            error = error1
        }
        if error != nil{
            
            print("\(error?.localizedDescription)")
        }
    
    
    }
    class func addItemCategoryInStore(categoryName: String!){
    
        if let currentStore = MerchantDataService.currentStore{
        
            var itemCategory = PFObject(className: "ItemCategory")
            itemCategory["name"] = categoryName
            itemCategory["store"] = currentStore
            
            var error: NSError? = nil
            do{
                let success = try itemCategory.save()
                //return array
            }catch let error1 as NSError{
                error = error1
            }
            if error != nil{
                
                print("\(error?.localizedDescription)")
            }
            
        
        }
    
    }
    
    // - MARK: Item Review
    class func findAllItemReviewInItem(item: Item) -> [PFObject]{
        
        
        let itemPFObject = PFObject(withoutDataWithClassName: "Item", objectId: item.objectId)
        let query = PFQuery(className: "ItemReview")
        query.whereKey("item", equalTo: itemPFObject)
        query.includeKey("item.category.store.category")
        query.includeKey("item.store.category")
        return MerchantDataService.queryAllObjects(query)
    }
    
    // - MARK: User
    class func findUserProfilePic(itemReview: ItemReview) -> PFFile?{
        
        let user = itemReview.user
        //print(user.objectId)
        let query = PFUser.query()
        query?.whereKey("objectId", equalTo: user.objectId!)
        print(query)
        if let userArray = MerchantDataService.queryAllObjects(query!) as? [PFObject]{
            
            let pic = userArray[0].valueForKey("profilePic") as? PFFile
            return pic
        }
        return nil
    }
    
}
