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
UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate{
    
    
    private struct NewItemStoryBoard{
    
        
        static let itemAttCellIdentifier = "ItemAttCell"
        
        static let itemAttArray = ["Name","Summary","Price", "Discount", "Category"]
        static let itemAttDetailsArray = ["add title here", "a longer description","$11.99","0.0","dinner"]
        
    }
    
    @IBOutlet weak var itemPictureCollectionView: UICollectionView!
    
    @IBOutlet weak var addItemPicButton: UIButton!
    
    @IBOutlet weak var newItemTableView: UITableView!
    
    @IBOutlet weak var categoryPickerView: UIPickerView!
    
    @IBOutlet weak var categoryPickerViewToolbar: UIToolbar!
    
    @IBOutlet weak var addItemButton: UIBarButtonItem!
    var itemImageArray = [UIImage]()
    
    var itemCategoryArray = [ItemCategory]()
    
    let picker = UIImagePickerController()
    
    //var newItem: Item!
    let defaults = NSUserDefaults.standardUserDefaults()
    
    var currentStore: Store!
    
    var newItemCategory: ItemCategory!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        picker.delegate = self
        // TODO: item category alert
        if itemCategoryArray.count != 0{
            newItemCategory = itemCategoryArray[0]
        }else{
        
            Utils.createPopupAlertView("Alert", message: "No item category", buttonTitle: "Cancel")
        }
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardDidAppear", name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardDidHide", name: UIKeyboardDidHideNotification, object: nil)
        
    }
    
    func keyboardDidAppear(){
        
        self.addItemButton.enabled = false
        self.addItemButton.tintColor = UIColor.clearColor()
    }
    
    func keyboardDidHide(){
        
        self.addItemButton.enabled = true
        self.addItemButton.tintColor = nil
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
        return NewItemStoryBoard.itemAttArray.count
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
        
        itemImageArray.append(chosenImage)
        itemPictureCollectionView.reloadData()
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    // MARK: Collection View
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemImageArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = itemPictureCollectionView.dequeueReusableCellWithReuseIdentifier("ItemPicCollectionViewCell", forIndexPath: indexPath) as! ItemPicCollectionViewCell
        let row = indexPath.row
        let image = itemImageArray[row]
        cell.newItemPic.image = image
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
        let cell = self.newItemTableView.cellForRowAtIndexPath(NSIndexPath(forRow: 4, inSection: 0)) as! ItemAttTableViewCell
        cell.details.text = itemCategoryArray[row].name
        newItemCategory = itemCategoryArray[row]
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
        
        
        let name = (newItemTableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as? ItemAttTableViewCell)?.details.text
        let summary = (newItemTableView.cellForRowAtIndexPath(NSIndexPath(forRow: 1, inSection: 0)) as? ItemAttTableViewCell)?.details.text
        var price = (newItemTableView.cellForRowAtIndexPath(NSIndexPath(forRow: 2, inSection: 0)) as? ItemAttTableViewCell)?.details.text
        price = price?.substringFromIndex((price?.startIndex)!.advancedBy(1))
        var discount = (newItemTableView.cellForRowAtIndexPath(NSIndexPath(forRow: 3, inSection: 0)) as? ItemAttTableViewCell)?.details.text
        let item = Item()
        item.category = newItemCategory
        item.isActive = true
        item.name = name!
        item.price = Double(price!)!
        item.summary = summary
        item.discount = Double(discount!)!
        item.store = self.currentStore
        item.saveInBackgroundWithBlock{(success: Bool, error: NSError?) -> Void in
        
        
            if (success){
                //TODO: Add item picture
                for itemImage in self.itemImageArray{
                
                    let itemPicture = ItemPicture()
                    itemPicture.picture = PFFile(data: UIImageJPEGRepresentation(itemImage, 0.5)!)
                    itemPicture.item = item
                    itemPicture.saveInBackground()
                
                }
                self.defaults.setBool(true, forKey: "reloadStore")
                self.navigationController?.popViewControllerAnimated(true)
            
            }else{
            
                //TODO: Show error
                print("Item saving")
                print("\(error.debugDescription)")
            
            }
        
        
        
        }
    
        
    }
    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//        if segue.identifier == NewItemStoryBoard.addNewItemSegueIdentifier{
//            let name = (newItemTableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as? ItemAttTableViewCell)?.details.text
//            let description = (newItemTableView.cellForRowAtIndexPath(NSIndexPath(forRow: 1, inSection: 0)) as? ItemAttTableViewCell)?.details.text
//            var price = (newItemTableView.cellForRowAtIndexPath(NSIndexPath(forRow: 2, inSection: 0)) as? ItemAttTableViewCell)?.details.text
//            price = price?.substringFromIndex((price?.startIndex)!.advancedBy(1))
//            
//            //let product = Item(title: title!, description: description!, price: price, categoryArray: categoriesTest, imageArray: picArray)
//            self.newItem["name"] = name
//            self.newItem["description"] = description
//            self.newItem["price"] = price
//            
//            if let spvc = segue.destinationViewController as? StorePageViewController{
//            
//                //spvc.newItem = product
//                spvc.addNewItemBool = true
//                //spvc.productCollectionView.reloadData()
//            }
//        }
//        
//    }
    

}
