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
        
        static let itemAttArray = ["Name","Description","Price", "Category"]
        static let itemAttDetailsArray = ["add title here", "a longer description","$11.99","dinner"]
        
    }
    
    @IBOutlet weak var itemPictureCollectionView: UICollectionView!
    
    @IBOutlet weak var addItemPicButton: UIButton!
    
    @IBOutlet weak var newItemTableView: UITableView!
    
    @IBOutlet weak var categoryPickerView: UIPickerView!
    
    @IBOutlet weak var categoryPickerViewToolbar: UIToolbar!
    
    var itemPictureArray = [UIImage]()
    
    var itemCategoryArray = [ItemCategory]()
    
    let picker = UIImagePickerController()
    
    var newItem: Item!
    
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
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! ItemAttTableViewCell
        if indexPath.row == 3 {
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
        
//        MerchantDataService.addItemPicture(newItem, itemImage: chosenImage)
//        itemPictureArray = MerchantDataService.findAllItemPictureInItem(newItem).map{ItemPicture(pfObj: $0)}
        itemPictureArray.append(chosenImage)
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
        let row = indexPath.row
        let image = itemPictureArray[row]
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
        let cell = self.newItemTableView.cellForRowAtIndexPath(NSIndexPath(forRow: 3, inSection: 0)) as! ItemAttTableViewCell
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
        let description = (newItemTableView.cellForRowAtIndexPath(NSIndexPath(forRow: 1, inSection: 0)) as? ItemAttTableViewCell)?.details.text
        var price = (newItemTableView.cellForRowAtIndexPath(NSIndexPath(forRow: 2, inSection: 0)) as? ItemAttTableViewCell)?.details.text
        price = price?.substringFromIndex((price?.startIndex)!.advancedBy(1))
//        self.newItem.name = name
//        self.newItem.description = description
//        self.newItem.price = Double(price!)
        
        MerchantDataService.addItemInStore(name, description: description, category: self.newItemCategory, price: price, itemPictureArray: itemPictureArray)
        self.navigationController?.popViewControllerAnimated(true)
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
