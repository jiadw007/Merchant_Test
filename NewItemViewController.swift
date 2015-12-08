//
//  NewItemViewController.swift
//  Merchant_Test
//
//  Created by FAWN on 15/11/3.
//  Copyright © 2015年 Talace. All rights reserved.
//

import UIKit
import Parse

class NewItemViewController:
UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate{
    
    
    private struct NewItemStoryBoard{
    
        
        static let itemAttCellIdentifier = "ItemAttCell"
        
        static let itemAttArray = ["Name","Description","Price", "Category"]
        static let itemAttDetailsArray = ["add title here", "a longer description","$11.99",""]
        static let addNewItemSegueIdentifier = "addNewItem"
    }
    
    @IBOutlet weak var itemPictureCollectionView: UICollectionView!
    
    @IBOutlet weak var addItemPicButton: UIButton!
    
    @IBOutlet weak var newItemTableView: UITableView!
    
    var itemPictureArray = [ItemPicture]()
    
    let picker = UIImagePickerController()
    
    var newItem: PFObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        picker.delegate = self
        newItem = PFObject(className: "item")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func backToParentViewController(){
        self.navigationController?.popViewControllerAnimated(true)
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 45
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(NewItemStoryBoard.itemAttCellIdentifier, forIndexPath: indexPath) as! ItemAttTableViewCell
        cell.title?.text = NewItemStoryBoard.itemAttArray[indexPath.row]
        cell.details?.text = NewItemStoryBoard.itemAttDetailsArray[indexPath.row]
        cell.detailsTextField.tag = indexPath.row
        return cell
        
        
    }
    
    // MARK: - Image Picker
    
    @IBAction func addItemPic(sender: UIButton) {
        picker.allowsEditing = false
        picker.sourceType = .PhotoLibrary
        presentViewController(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
    
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        //print(chosenImage)
        //picArray.append(chosenImage)
        //MerchantDataService.addItemPicture(newItem, itemImage: chosenImage)
        //itemPictureArray = MerchantDataService.findAllItemPictureInItem(newItem)
        itemPictureCollectionView.reloadData()
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    // MARK: Collection View
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemPictureArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = itemPictureCollectionView.dequeueReusableCellWithReuseIdentifier("ItemPicCollectionViewCell", forIndexPath: indexPath) as! ItemPicCollectionViewCell
        
        //cell.newItemPic.image = picArray[indexPath.row]
        
        return cell
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == NewItemStoryBoard.addNewItemSegueIdentifier{
            let name = (newItemTableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as? ItemAttTableViewCell)?.details.text
            let description = (newItemTableView.cellForRowAtIndexPath(NSIndexPath(forRow: 1, inSection: 0)) as? ItemAttTableViewCell)?.details.text
            var price = (newItemTableView.cellForRowAtIndexPath(NSIndexPath(forRow: 2, inSection: 0)) as? ItemAttTableViewCell)?.details.text
            price = price?.substringFromIndex((price?.startIndex)!.advancedBy(1))
            
            //let product = Item(title: title!, description: description!, price: price, categoryArray: categoriesTest, imageArray: picArray)
            self.newItem["name"] = name
            self.newItem["description"] = description
            self.newItem["price"] = price
            
            if let spvc = segue.destinationViewController as? StorePageViewController{
            
                //spvc.newItem = product
                spvc.addNewItemBool = true
                //spvc.productCollectionView.reloadData()
            }
        }
        
    }
    

}
