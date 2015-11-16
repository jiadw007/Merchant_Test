//
//  StoryPageViewController.swift
//  Merchant_Test
//
//  Created by FAWN on 15/11/3.
//  Copyright © 2015年 Talace. All rights reserved.
//

import UIKit

class StorePageViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    // TODO: Get store categories
    private var categoriesTest = ["Category 1", "Category 2", "Category 3"]
    
    var productTestArray = [Product]()
    
    var addNewItemBool = false
    
    var newItem : Product?
    
    @IBOutlet weak var productSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var productCollectionView: UICollectionView!
    
    private struct StorePageStoryBoard{
    
        static let categorySegueIdentifier = "showCateogries"
        static let newItemSegueIdentifier = "addNewItem"
        static let showProductDetailsSegueIdentifier = "showProductDetails"
        static let productCollectionCellReuseIdentifier = "productCollectionCell"
    
    }

    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        //TODO: Link to product data
        let product_1 = Product(title: "Red Dragon Roll", description: "Red Dragon Roll", price: "11.99", categoryArray: self.categoriesTest, imageArray: [UIImage(named:"Red Dragon Roll")!, UIImage(named: "Red Dragon Roll")!])
        let product_2 = Product(title: "Spicy Tuna Roll", description: "Spicy Tuna Roll", price: "7.99", categoryArray: self.categoriesTest, imageArray: [UIImage(named:"Spicy Tuna")!,UIImage(named:"Spicy Tuna")!])
        let product_3 = Product(title: "Califonia Roll", description: "California Roll", price: "7.99", categoryArray: self.categoriesTest, imageArray: [UIImage(named:"California Roll")!])
        let product_4 = product_1
        let product_5 = product_2
        let product_6 = product_3
        let product_7 = product_1
        let product_8 = product_2
        let product_9 = product_3
        productTestArray = [product_1, product_2, product_3, product_4, product_5,product_6,product_7,product_8,product_9]
        
        if addNewItemBool == true && newItem != nil{
        
            productTestArray.append(newItem!)
            addNewItemBool = false
            newItem = nil
        }
        
        self.productCollectionView.reloadData()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Collection View
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productTestArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(StorePageStoryBoard.productCollectionCellReuseIdentifier, forIndexPath: indexPath) as! ProductCollectionViewCell
        
        cell.productImageView.image = self.productTestArray[indexPath.row].imageArray[0]
        cell.productTitle.text = self.productTestArray[indexPath.row].title
        cell.productPrice.text = "$\(self.productTestArray[indexPath.row].price)"
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
                dest.categoriesTest = self.categoriesTest
            }
            
        
        }else if segue.identifier == StorePageStoryBoard.newItemSegueIdentifier{
        
            if let dest = segue.destinationViewController as? NewItemViewController{
            
                let backItem = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: dest, action: "backToParentViewController")
                dest.navigationItem.leftBarButtonItem = backItem

            }
        }else if segue.identifier == StorePageStoryBoard.showProductDetailsSegueIdentifier {
            
            if let dest = segue.destinationViewController as? ProductDetailsViewController{
                if let productCell = sender as? UICollectionViewCell {
                    let index = self.productCollectionView.indexPathForCell(productCell)
                    let backItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
                    navigationItem.backBarButtonItem = backItem
                    
                    dest.product = productTestArray[(index?.row)!]
                    print(index?.row)
                    dest.rowNum = (index?.row)!
                    dest.navigationItem.title = dest.product.title
                }
                
            }
                    
        }
    }
    func backToParent(){
        
        print("sdc")
    }


}
