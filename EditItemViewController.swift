//
//  EditItemViewController.swift
//  Merchant_Test
//
//  Created by FAWN on 15/11/8.
//  Copyright © 2015年 Talace. All rights reserved.
//

import UIKit
import Parse

class EditItemViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    
    private struct EditItemStoryBoard{
        
        static let itemAttCellIdentifier = "ItemAttCell"
        static let editItemDoneSegueIdentifier = "EditItemDone"
        static let itemAttArray = ["Name","Summary","Price", "Discount", "Category"]
    }
    
    
    @IBOutlet weak var itemPictureCollectionView: UICollectionView!
    
    @IBOutlet weak var addItemPicButton: UIButton!
    
    @IBOutlet weak var itemTableView: UITableView!
    
    @IBOutlet weak var categoryPickerView: UIPickerView!
    
    @IBOutlet weak var categoryPickerViewToolbar: UIToolbar!
    
    @IBOutlet weak var editItemButton: UIBarButtonItem!
    
    var item: Item!
    
    var itemPictureArray: [ItemPicture]!
    
    var itemCategoryArray: [ItemCategory]!
    
    let picker = UIImagePickerController()
    
    var itemCategoryIndex : Int?
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    override func viewWillAppear(animated: Bool) {
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        picker.delegate = self
        var error: NSError? = nil
        do{
            
            self.itemCategoryIndex = try itemCategoryArray.indexOf{$0.objectId ==  item.category.objectId}
            //print(index)
            
            categoryPickerView.selectRow(self.itemCategoryIndex!, inComponent: 0, animated: true)
            
        }catch let error1 as NSError{
            error = error1
        }
        if error != nil{
            
            print("\(error?.localizedDescription)")
        }
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardDidAppear", name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardDidHide", name: UIKeyboardDidHideNotification, object: nil)
    }
    
    
    func keyboardDidAppear(){
    
        self.editItemButton.enabled = false
        self.editItemButton.tintColor = UIColor.clearColor()
    }
    
    func keyboardDidHide(){
        
        self.editItemButton.enabled = true
        self.editItemButton.tintColor = nil
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
        return EditItemStoryBoard.itemAttArray.count
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
            cell.details.text = item.summary
        case 2:
            cell.details.text = "$\(item.price)"
        case 3:
            cell.details.text = "\(item.discount)"
        case 4:
            cell.details.text = itemCategoryArray[self.itemCategoryIndex!].name
            
        default:
            break
        }
        //cell.details?.text = NewItemStoryBoard.itemAttDetailsArray[indexPath.row]
        cell.detailsTextField.tag = indexPath.row
        cell.detailsTextField.placeholder = EditItemStoryBoard.itemAttArray[indexPath.row]
        
        
        return cell
        
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! ItemAttTableViewCell
        if indexPath.row == 4 {
            self.view.endEditing(true)
            showPicker()
        }else{
            
            cell.detailsTextField.hidden = false
            cell.details.hidden = true
            cell.detailsTextField.text = cell.details.text
            hidePicker()
        }
    }
    
    // MARK: - Image Picker
    
    @IBAction func addItemPic(sender: UIButton) {
        picker.allowsEditing = false
        picker.sourceType = .PhotoLibrary
        presentViewController(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        //DONE : Add new item picture
        let itemPicture = ItemPicture()
        itemPicture.item = self.item
        itemPicture.picture = PFFile(data: UIImageJPEGRepresentation(chosenImage, 0.5)!)
        itemPicture.saveInBackgroundWithBlock{(success: Bool, error: NSError?) -> Void in
        
            if (success){
                
                self.itemPictureCollectionView.reloadData()

            }else{
            //TODO: Show Error
                print("Item picture saving")
                print("\(error.debugDescription)")
            
            }
        }
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
    // - MARK: PickerView delegate and data sources
    // MARK: Data sources
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return  itemCategoryArray.count
    }

    // MARK: Delegate
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let titleData = itemCategoryArray[row].name
        let title = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 15.0)!,NSForegroundColorAttributeName:UIColor.blueColor()])
        return title

    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return itemCategoryArray[row].name
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let cell = self.itemTableView.cellForRowAtIndexPath(NSIndexPath(forRow: 4, inSection: 0)) as! ItemAttTableViewCell
        cell.details.text = itemCategoryArray[row].name
        item.category = itemCategoryArray[row]
    }
    
    func showPicker(){
        self.categoryPickerView.hidden = false
        self.categoryPickerViewToolbar.hidden = false
    
    }
    
    func hidePicker(){
    
        self.categoryPickerView.hidden = true
        self.categoryPickerViewToolbar.hidden = true
    }
    
    
    @IBAction func cancelPicker(sender: UIBarButtonItem) {
        hidePicker()
    }
    
    @IBAction func donePicker(sender: UIBarButtonItem) {
        hidePicker()
    }
    
    // MARK: - Navigation
    
    @IBAction func backToParentViewController(sender: UIBarButtonItem) {
       
        
        
        let name = (itemTableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as? ItemAttTableViewCell)?.details.text
        let summary = (itemTableView.cellForRowAtIndexPath(NSIndexPath(forRow: 1, inSection: 0)) as? ItemAttTableViewCell)?.details.text
        var price = (itemTableView.cellForRowAtIndexPath(NSIndexPath(forRow: 2, inSection: 0)) as? ItemAttTableViewCell)?.details.text
        price = price?.substringFromIndex((price?.startIndex)!.advancedBy(1))
        var discount = (itemTableView.cellForRowAtIndexPath(NSIndexPath(forRow: 3, inSection: 0)) as? ItemAttTableViewCell)?.details.text
        //self.item.updateItem()
        let query = Item.query()!
        query.getObjectInBackgroundWithId(self.item.objectId!){(itemObject: PFObject?, error: NSError?) -> Void in
            
            if error != nil{
                //TODO: Show error
                
            }else if let itemObject = itemObject{
                
                itemObject["name"] = name!
                itemObject["summary"] = summary!
                itemObject["category"] = self.item.category
                itemObject["discount"] = Double(discount!)!
                itemObject["price"] = Double(price!)!
                
                self.defaults.setBool(true, forKey: "reloadItem")
                self.defaults.setBool(true, forKey: "reloadStore")
                itemObject.saveInBackground()
                self.navigationController?.popViewControllerAnimated(true)
            }
            
        }
        
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
