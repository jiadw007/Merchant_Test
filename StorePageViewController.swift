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
    
    //var currentMerchant : PFUser!

    var currentStore: Store!
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    @IBOutlet weak var storeLogoImageView: UIImageView!
    
    @IBOutlet weak var itemSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var itemCollectionView: UICollectionView!
    
    @IBOutlet weak var storeNameLabel: UILabel!
    
    private struct StorePageStoryBoard{
    
        static let categorySegueIdentifier = "showItemCateogries"
        static let newItemSegueIdentifier = "addNewItem"
        static let showItemDetailsSegueIdentifier = "showItemDetails"
        static let itemCollectionCellReuseIdentifier = "itemCollectionCell"
    
    }
    override func viewWillAppear(animated: Bool) {
        
        // Check reload
        let reload = defaults.boolForKey("reloadStore")
        if (reload){
        
            loadAllItem()
            defaults.setBool(false, forKey: "reloadStore")
        }else{
            self.itemCollectionView.reloadData()
        }
    }

    override func viewDidLoad() {
    
        super.viewDidLoad()
        
        //DONE: Load current store
        loadCurrentStore()
        
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
                    self.storeNameLabel.text = self.currentStore.name
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
            
            let imageFile = self.currentStore.logo
            imageFile.getDataInBackgroundWithBlock{ (data: NSData? , error : NSError?) -> Void in
            
                if error == nil{
                
                    self.storeLogoImageView.image = UIImage(data: data!)
        
                }
            
            
            }
            
            
        }
    
    }
    
    func loadAllItem(){
        
        if self.currentStore != nil{
            //print("load")
            let query = Item.query()!
            
            query.whereKey("store", equalTo: self.currentStore)
            query.includeKey("category.store.category")
            query.includeKey("store.category")
            query.orderByDescending("updatedAt")
            // Find all items
            query.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error: NSError?) -> Void in
                
                if error == nil{
                
                    if let objects = objects as? [Item]{
                        

                        self.itemArray = objects
                        self.itemCollectionView.reloadData()

                    }
                    
                }else{
                    //TODO: Show Error
                    print("\(error?.localizedDescription)")
                
                }
                
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
        //var itemImageArray = [UIImage]()
        let query = ItemPicture.query()!
        query.whereKey("item", equalTo: item)
        query.orderByAscending("updatedAt")
        query.getFirstObjectInBackgroundWithBlock{(object : PFObject?, error: NSError?) -> Void in
            
            if error == nil {
            
                if let object = object as? ItemPicture{
                
                    let imageFile = object.picture
                    
                    imageFile.getDataInBackgroundWithBlock{(data: NSData?, error: NSError?) -> Void in
                        
                        if error == nil{
                        
                            let image = UIImage(data: data!)
                            dispatch_async(dispatch_get_main_queue()){
                                cell.itemImageView.image = image
                            }
                        }
                        
                    }
                
                }
            
            }
        
        
        
        }
//        query.findObjectsInBackgroundWithBlock{(objects: [PFObject]?, error: NSError?) -> Void in
//        
//            if error == nil{
//            
//                if let objects = objects as? [ItemPicture]{
//                    
//                    for object in objects{
//                    
//                        let imageFile = object.picture
//                        var error:NSError? = nil
//                        do{
//                            
//                            let image = UIImage(data: try imageFile!.getData())
//                            itemImageArray.append(image!)
//                            
//                        }catch let error1 as NSError {
//                            error = error1
//                        }
//                        if (error != nil) {
//                            print("\(error?.localizedDescription)")
//                        }
//                        
//                    }
//                    
//                    cell.itemImageView.animationImages = itemImageArray
//                    cell.itemImageView.animationDuration = NSTimeInterval(6.0 * Double(itemImageArray.count))
//                    print("\(item.name) delay read")
//                    cell.itemImageView.startAnimating()
//                }
//            
//            
//            }
//        }
       
        cell.itemTitle.text = item.name
        
        if item.discount != 0 {
            
            cell.itemPrice.text = "$\(round(item.price * item.discount * 10) / 10)"
        }else{
        
            cell.itemPrice.text = "$\(item.price)"

        }
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
                dest.currentStore = self.currentStore

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
