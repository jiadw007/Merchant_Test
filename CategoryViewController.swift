//
//  categoryViewController.swift
//  Merchant_Test
//
//  Created by FAWN on 15/11/3.
//  Copyright © 2015年 Talace. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private struct CategoryStoryboard{
    
        static let categoryCellIdentifier = "categoryCell"
    
    }
    
    var itemCategoryArray = [ItemCategory]()

    @IBOutlet weak var categoryTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func editButtonPushed(sender: AnyObject) {
        
        if self.categoryTableView.editing{
            
            self.categoryTableView.setEditing(false, animated: true)
            self.navigationItem.rightBarButtonItem? = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Edit, target: self, action: "editButtonPushed:")
            navigationItem.leftBarButtonItem = nil
            let backItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
            navigationItem.backBarButtonItem = backItem
        }else{
        
            self.categoryTableView.setEditing(true, animated: true)
            self.navigationItem.rightBarButtonItem? = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: "editButtonPushed:")
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Cancel, target: self, action: "editCancel")
            
        }
    }
    func editCancel(){
        
        self.categoryTableView.setEditing(false, animated: true)
        let backItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        navigationItem.leftBarButtonItem = nil
        navigationItem.backBarButtonItem = backItem
        self.navigationItem.rightBarButtonItem? = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Edit, target: self, action: "editButtonPushed:")
        
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemCategoryArray.count + 1
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(CategoryStoryboard.categoryCellIdentifier, forIndexPath: indexPath) as! CategoryTableViewCell
        //cell.imageView?.image = UIImage(named: "Warning")
        if indexPath.row <= itemCategoryArray.count - 1{
            cell.title.text = itemCategoryArray[indexPath.row].name
            cell.listButton.setImage(UIImage(named: "reveal-icon"), forState: .Normal)
        }else{
        
            cell.title.text = "Add Item Category"
            cell.listButton.setImage(nil, forState: .Normal)
        }
        return cell
    }
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.Delete
    }
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete{
            
            let itemCategory = self.itemCategoryArray[indexPath.row]
            self.itemCategoryArray.removeAtIndex(indexPath.row)
            
            MerchantDataService.deleteItemCategoryInStore(itemCategory)
            self.categoryTableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
            
        }
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == itemCategoryArray.count{
            let alertController = UIAlertController(title: "New Item Category", message: "Please input new item category name", preferredStyle: .Alert)
            let confirmAction = UIAlertAction(title: "Add", style: .Default){
            
                (_) in
                if let field = alertController.textFields![0] as? UITextField{
                    
                    MerchantDataService.addItemCategoryInStore(field.text!)
                    self.itemCategoryArray = MerchantDataService.findAllItemCategoriesInStore().map{ItemCategory.init(pfObj: $0)}
                    self.categoryTableView.reloadData()
                }else{
                    //user did not fill field
                
                }
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
            alertController.addTextFieldWithConfigurationHandler{(textField) in
                textField.placeholder = "Item Category Name"
            }
            alertController.addAction(confirmAction)
            alertController.addAction(cancelAction)
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
