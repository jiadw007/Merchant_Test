//
//  EditItemViewController.swift
//  Merchant_Test
//
//  Created by FAWN on 15/11/8.
//  Copyright © 2015年 Talace. All rights reserved.
//

import UIKit

class EditItemViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    private struct EditItemStoryBoard{
        
        static let itemAttCellIdentifier = "ItemAttCell"
        static let editItemDoneSegueIdentifier = "EditItemDone"
        static let itemAttArray = ["Name","Description","Price", "Category"]
    }
    
    
    @IBOutlet weak var itemImageCollectionView: UICollectionView!
    
    @IBOutlet weak var addItemPicButton: UIButton!
    
    @IBOutlet weak var itemTableView: UITableView!
    
    var item: Item!
    
    var itemPictureArray: [ItemPicture]!
    
    let picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        picker.delegate = self
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
        
        let cell = tableView.dequeueReusableCellWithIdentifier(EditItemStoryBoard.itemAttCellIdentifier, forIndexPath: indexPath) as! ItemAttTableViewCell
        cell.title?.text = EditItemStoryBoard.itemAttArray[indexPath.row]
        switch indexPath.row{
        
        case 0:
            cell.details.text = item.name
        case 1:
            cell.details.text = item.description
        case 2:
            cell.details.text = "$\(item.price)"
        default:
            cell.details.text = ""
        }
        //cell.details?.text = NewItemStoryBoard.itemAttDetailsArray[indexPath.row]
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
        MerchantDataService.addItemPicture(item, itemImage: chosenImage)
        itemPictureArray =  MerchantDataService.findAllItemPictureInItem(item).map{ItemPicture(pfObj: $0)}
        itemImageCollectionView.reloadData()
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
        let cell = itemImageCollectionView.dequeueReusableCellWithReuseIdentifier("ItemPicCollectionViewCell", forIndexPath: indexPath) as! ItemPicCollectionViewCell
        
        let row = indexPath.row
        
        if let imageFile = itemPictureArray[row].picture{
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                
                var error:NSError? = nil
                do{
                    
                    let image = UIImage(data: try imageFile.getData())
                    dispatch_async(dispatch_get_main_queue()) {
                        if true {
                            cell.newItemPic.image = image
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
        return cell
    }
    
    
    // MARK: - Navigation
    
    @IBAction func backToParentViewController(sender: UIBarButtonItem) {
       
            
        let name = (itemTableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as? ItemAttTableViewCell)?.details.text
        let description = (itemTableView.cellForRowAtIndexPath(NSIndexPath(forRow: 1, inSection: 0)) as? ItemAttTableViewCell)?.details.text
        var price = (itemTableView.cellForRowAtIndexPath(NSIndexPath(forRow: 2, inSection: 0)) as? ItemAttTableViewCell)?.details.text
        price = price?.substringFromIndex((price?.startIndex)!.advancedBy(1))
        self.item.name = name
        self.item.description = description
        self.item.price = Double(price!)
        MerchantDataService.updateItemInStore(item)
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
        
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//        
//        if segue.identifier == EditItemStoryBoard.editItemDoneSegueIdentifier{
//            
//            let name = (itemTableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as? ItemAttTableViewCell)?.details.text
//            let description = (itemTableView.cellForRowAtIndexPath(NSIndexPath(forRow: 1, inSection: 0)) as? ItemAttTableViewCell)?.details.text
//            var price = (itemTableView.cellForRowAtIndexPath(NSIndexPath(forRow: 2, inSection: 0)) as? ItemAttTableViewCell)?.details.text
//            price = price?.substringFromIndex((price?.startIndex)!.advancedBy(1))
//            self.item.name = name
//            self.item.description = description
//            self.item.price = Double(price!)
//            if let dest = segue.destinationViewController as? ItemDetailsViewController{
//                
//                let backItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: dest, action: "backToParentViewController")
//                navigationItem.backBarButtonItem = backItem
//                dest.item = item
//                dest.itemPictureArray = itemPictureArray
//                //spvc.productCollectionView.reloadData()
//            }
//        }
//        
//    }


}
