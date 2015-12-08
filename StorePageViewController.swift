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
        //TODO: Load all items
        itemArray = MerchantDataService.findAllItemsInStore().map{Item.init(pfObj: $0)}
        //TODO: Load all item categories
        itemCategoriesArray = MerchantDataService.findAllItemCategoriesInStore().map{ItemCategory.init(pfObj: $0)}
        //TODO: Load current store
        loadCurrentStore()
        self.itemCollectionView.reloadData()

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
    
        self.currentStore = MerchantDataService.findMerchantStore().map{Store(pfObj: $0)}
        let imageFile = self.currentStore.logo
        var error:NSError? = nil
        do{
            
            let image = UIImage(data: try imageFile.getData())
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
    
    // MARK: - Collection View
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(StorePageStoryBoard.itemCollectionCellReuseIdentifier, forIndexPath: indexPath) as! ItemCollectionViewCell
        let item = self.itemArray[indexPath.row]
        if let imageFile = MerchantDataService.fetchImageFile(item){
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                
                var error:NSError? = nil
                do{
                    
                    let image = UIImage(data: try imageFile.getData())
                    dispatch_async(dispatch_get_main_queue()) {
                        if true {
                            cell.itemImageView.image = image
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
            }
            
        
        }else if segue.identifier == StorePageStoryBoard.newItemSegueIdentifier{
        
            if let dest = segue.destinationViewController as? NewItemViewController{
            
                let backItem = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: dest, action: "backToParentViewController")
                dest.navigationItem.leftBarButtonItem = backItem

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
                    //dest.navigationItem.title = dest.item.name
                }
                
            }
                    
        }
    }
    func backToParent(){
        
        print("sdc")
    }
    

}
