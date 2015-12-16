//
//  StoryPageViewController.swift
//  Merchant_Test
//
//  Created by FAWN on 15/11/3.
//  Copyright © 2015年 Talace. All rights reserved.
//

import UIKit
import Parse

class StorePageViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    // TODO: Get all item categories in store
    
    var itemCategoriesArray = [ItemCategory]()
    
    var itemArray = [Item]()
    
    var addNewItemBool = false
    
    var newItem : Item?
    
    //var currentMerchant : PFUser!

    var currentStore: Store!
    
    //let defaults = NSUserDefaults.standardUserDefaults()
    
    @IBOutlet weak var storeLogoImageView: UIImageView!
    
    @IBOutlet weak var itemSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var itemCollectionView: UICollectionView!
    
    private struct StorePageStoryBoard{
    
        static let categorySegueIdentifier = "showItemCateogries"
        static let newItemSegueIdentifier = "addNewItem"
        static let showItemDetailsSegueIdentifier = "showItemDetails"
        static let itemCollectionCellReuseIdentifier = "itemCollectionCell"
    
    }
    override func viewWillAppear(animated: Bool) {
        
        //DONE: Load current store
        loadCurrentStore()

    }

    override func viewDidLoad() {
    
        super.viewDidLoad()
       
        if addNewItemBool == true && newItem != nil{
        
            itemArray.append(newItem!)
            addNewItemBool = false
            newItem = nil
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadCurrentStore(){
        
        let merchant = PFUser.currentUser()
        let query = Store.query()!
        
        query.whereKey("owner", equalTo: merchant!)
        query.includeKey("category")
        query.getFirstObjectInBackgroundWithBlock{ (object: PFObject?, error : NSError? ) -> Void in
            
            if error == nil{
                
                if let store = object as? Store{
                    self.currentStore = store
                    //self.defaults.setObject(self.currentStore, forKey: "currentStore")
                    //TODO: Load Store Logo
                    self.loadStoreLogo()
                    //TODO: Load All Items
                    self.loadAllItem()
                    //TODO: Load All ItemCategories
                    self.loadAllItemCategory()
                }
            }
        
        }
        
    }
    
    func loadStoreLogo(){
    
        if self.currentStore != nil{
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                
                let imageFile = self.currentStore.logo
                var error:NSError? = nil
                do{
                    
                    let image = UIImage(data: try imageFile!.getData())
                    dispatch_async(dispatch_get_main_queue()) {
                        if true {
                           self.storeLogoImageView.image = image
                        }
                    }
                    
                }catch let error1 as NSError {
                    error = error1
                }
                if (error != nil) {
                    print("\(error?.localizedDescription)")
                }
            }
            
            
        }
    
    }
    
    func loadAllItem(){
        
        if self.currentStore != nil{
            let query = Item.query()!
            query.whereKey("store", equalTo: self.currentStore)
            query.includeKey("category.store.category")
            query.includeKey("store.category")
            query.orderByDescending("updatedAt")
            // Find all items
            query.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error: NSError?) -> Void in
                
                if error == nil{
                
                    if let objects = objects as? [Item]{
                    
                        //for object in objects{
                        
                            self.itemArray = objects
                        //}
                    
                    }
                    
                }else{
                    //TODO: Show Error
                    print("\(error?.localizedDescription)")
                
                }
                self.itemCollectionView.reloadData()
                
            }
        }
    
    }
    
    func loadAllItemCategory(){
        
        if self.currentStore != nil{
        
            let query = ItemCategory.query()!
            query.whereKey("store", equalTo: self.currentStore)
            query.includeKey("store.category")
            query.orderByDescending("updatedAt")
            query.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error: NSError?) -> Void in
             
                if error == nil{
                
                    if let objects = objects as?[ItemCategory]{
                    
                        for object in objects{
                            self.itemCategoriesArray.append(object)
                        }
                    
                    }
                
                }else{
                    //TODO: Show Error
                    print("\(error?.localizedDescription)")
                    
                }
                
            }
        
        
        }

        
    
    }

    // MARK: - Collection View
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(StorePageStoryBoard.itemCollectionCellReuseIdentifier, forIndexPath: indexPath) as! ItemCollectionViewCell
        let item = self.itemArray[indexPath.row]
        
        let query = ItemPicture.query()!
        query.whereKey("item", equalTo: item)
        query.orderByAscending("updatedAt")
        query.getFirstObjectInBackgroundWithBlock { (object: PFObject?, error: NSError?) -> Void in
        
            if error == nil{
            
                if let object = object as? ItemPicture{
                
                    let imageFile = object.picture
                    var error: NSError? = nil
                    do{
                        
                        let image = UIImage(data: try imageFile.getData())
                        cell.itemImageView.image = image
                        cell.itemImageView.layer.cornerRadius = 10
                        cell.itemImageView.clipsToBounds = true
                        
                    
                    }catch let error1 as NSError {
                        error = error1
                    }
                    if (error != nil) {
                        print("\(error?.localizedDescription)")
                    }
                
                }
            
            }
        
        
        }
        
        cell.itemTitle.text = item.name
        cell.itemPrice.text = "$\(item.price)"
        return cell
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == StorePageStoryBoard.categorySegueIdentifier{
            
            if let dest = segue.destinationViewController as? CategoryViewController{
            
                let backItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
                navigationItem.backBarButtonItem = backItem
                dest.itemCategoryArray = self.itemCategoriesArray
                dest.currentStore = self.currentStore
            }
            
        
        }else if segue.identifier == StorePageStoryBoard.newItemSegueIdentifier{
        
            if let dest = segue.destinationViewController as? NewItemViewController{
            
                let backItem = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: dest, action: "backToParentViewController")
                dest.navigationItem.leftBarButtonItem = backItem
                dest.itemCategoryArray = self.itemCategoriesArray

            }
        }else if segue.identifier == StorePageStoryBoard.showItemDetailsSegueIdentifier {
            
            if let dest = segue.destinationViewController as? ItemDetailsViewController{
                if let itemCell = sender as? UICollectionViewCell {
                    let index = self.itemCollectionView.indexPathForCell(itemCell)
                    let backItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
                    navigationItem.backBarButtonItem = backItem
                    
                    dest.item = itemArray[(index?.row)!]
                    dest.storeLogo = self.storeLogoImageView.image
                    //print(index?.row)
                    dest.rowNum = (index?.row)!
                    dest.itemCategoryArray = self.itemCategoriesArray
                    //dest.navigationItem.title = dest.item.name
                }
                
            }
                    
        }
    }
    func backToParent(){
        
        print("sdc")
    }
    

}
