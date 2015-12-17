//
//  OrderPageViewController.swift
//  Merchant_Test
//
//  Created by FAWN on 15/11/1.
//  Copyright © 2015年 Talace. All rights reserved.
//

import UIKit
import Parse


class OrderPageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var searchBar: UISearchBar!

    @IBOutlet weak var orderStatusSegmentControl: UISegmentedControl!
    
    @IBOutlet weak var orderTableView: UITableView!
    
    var orderArray = [Order]()
    
    var processedOrderArray = [Order]()
    
    var serviceArray = [Order]()
    
    var currentStore : Store!
    
    private struct OrderPageStoryBoard{
        
        static let orderCellReuseIdentifier = "OrderTableCell"
        static let serviceCellReuseIdentifier = "ServiceTableCell"
    }
    override func viewWillAppear(animated: Bool) {

        // TODO: Link to order data, Add
        // Query pending order
        let query = Order.query()!
        query.whereKey("status", equalTo: "pending")
        query.orderByDescending("updatedAt")
        query.findObjectsInBackgroundWithBlock{(objects: [PFObject]?, error: NSError? ) -> Void in
        
            if error == nil{
            
                if let objects = objects as? [Order]{
                    
                    self.orderArray = objects
                    if self.orderArray.count != 0{
                        let oneThird = self.orderArray.count / 3
                        self.serviceArray = Array(self.orderArray[0...oneThird])
                    }
                    self.orderTableView.reloadData()
                }
            }
        
        
        }
        
        // Query processed order
        let query2 = Order.query()!
        query2.whereKey("status", equalTo: "processed")
        query2.orderByDescending("updatedAt")
        query2.findObjectsInBackgroundWithBlock{(objects: [PFObject]?, error: NSError?) -> Void in
        
            if error == nil{
            
                if let objects = objects as? [Order]{
                
                    self.processedOrderArray = objects
                    //self.orderTableView.reloadData()
                
                }
            
            }
            
        
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.orderTableView.rowHeight = UITableViewAutomaticDimension
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table View
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        switch self.orderStatusSegmentControl.selectedSegmentIndex{
            
        case 0:
            return orderArray.count
        case 2:
            return processedOrderArray.count
        default:
            return 0
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch self.orderStatusSegmentControl.selectedSegmentIndex{
        case 0:
            if indexPath.section < serviceArray.count{
        
                return 30
            }else{
                return 92
            }
        default:
            return 92
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        switch self.orderStatusSegmentControl.selectedSegmentIndex{
        case 0:
            
            if indexPath.section >= serviceArray.count { //Order Table Cell
                let cell = tableView.dequeueReusableCellWithIdentifier(OrderPageStoryBoard.orderCellReuseIdentifier, forIndexPath: indexPath) as? OrderTableCell
                let order = orderArray[indexPath.section - serviceArray.count]
                cell?.orderNoLabel.text = "Order # \(indexPath.section)"
                
                //TODO: user and item info
                let query = PFUser.query()!
                query.whereKey("objectId", equalTo: order.user)
                query.getFirstObjectInBackgroundWithBlock{(object: PFObject?, error: NSError?) -> Void in
                    
                    if error == nil{
                        
                        if let object = object as? PFUser{
                            
                            cell?.customerNameLabel.text = object.username
                            
                        }
                        
                    }
                    
                    
                }
                let itemPictureQuery = ItemPicture.query()!
                itemPictureQuery.whereKey("objectId", equalTo: order.item)
                itemPictureQuery.orderByDescending("updatedAt")
                itemPictureQuery.getFirstObjectInBackgroundWithBlock{(object: PFObject?, error : NSError?) -> Void in
                    
                    if error == nil{
                    
                        if let object = object as? ItemPicture{
                            
                            let imageFile = object.picture
                            var error:NSError? = nil
                            do{
                                
                                let image = UIImage(data: try imageFile!.getData())
                                cell?.orderImageView.image = image
                                
                            }catch let error1 as NSError {
                                error = error1
                            }
                            if (error != nil) {
                                print("\(error?.localizedDescription)")
                            }
                        
                        }
                    
                    }
                
                }
                
                //TODO: Transform updatedat as time interval
                cell?.orderTimeLabel.text = "\(order.updatedAt)"
                
                
                cell?.orderDetailsLabel.text = "\(order.summary)"
                cell?.orderPriceLabel.text = "$\(order.price)"
                cell?.tableNoLabel.text = "Table #\(order.tableNo)"
                cell?.layer.borderWidth = 1.0
                cell?.layer.borderColor = UIColor.blueColor().CGColor
                cell?.layer.cornerRadius = 10.0
                return cell!
            }else{  // Service Cell
                
                let cell = tableView.dequeueReusableCellWithIdentifier(OrderPageStoryBoard.serviceCellReuseIdentifier, forIndexPath: indexPath) as? ServiceTableCell
                let service = serviceArray[indexPath.section]
                cell?.serviceImageView.image = UIImage(named: "Warning")
                cell?.tableNoLabel.text = "Table #\(service.tableNo)"
                
                //TODO: user info
                let query = PFUser.query()
                query?.whereKey("objectId", equalTo: service.user)
                query?.getFirstObjectInBackgroundWithBlock{(object: PFObject?, error: NSError?) -> Void in
                    
                    if error == nil{
                        
                        if let object = object as? PFUser{
                            
                            cell?.customerNameLabel.text = object.username
                            
                        }
                        
                    }
                    
                    
                }
                //TODO: Transform updatedat as time interval
                cell?.serviceTimeLabel.text = "\(service.updatedAt)"
                cell?.layer.borderWidth = 1.0
                cell?.layer.borderColor = UIColor.redColor().CGColor
                cell?.layer.cornerRadius = 10.0
                return cell!
            }
        case 2:
            let cell = tableView.dequeueReusableCellWithIdentifier(OrderPageStoryBoard.orderCellReuseIdentifier, forIndexPath: indexPath) as? OrderTableCell
            let order = processedOrderArray[indexPath.section]
            cell?.orderNoLabel.text = "Order # \(indexPath.section)"
            
            //TODO: Transform updatedat as time interval
            cell?.orderTimeLabel.text = "\(order.updatedAt)"
            //TODO: user and item info
            let query = PFUser.query()
            query?.whereKey("objectId", equalTo: order.user)
            query?.getFirstObjectInBackgroundWithBlock{(object: PFObject?, error: NSError?) -> Void in
                
                if error == nil{
                    
                    if let object = object as? PFUser{
                        
                        cell?.customerNameLabel.text = object.username
                        
                    }
                    
                }
                
                
            }
            let itemPictureQuery = ItemPicture.query()!
            itemPictureQuery.whereKey("objectId", equalTo: order.item)
            itemPictureQuery.orderByDescending("updatedAt")
            itemPictureQuery.getFirstObjectInBackgroundWithBlock{(object: PFObject?, error : NSError?) -> Void in
                
                if error == nil{
                    
                    if let object = object as? ItemPicture{
                        
                        let imageFile = object.picture
                        var error:NSError? = nil
                        do{
                            
                            let image = UIImage(data: try imageFile!.getData())
                            cell?.orderImageView.image = image
                            
                        }catch let error1 as NSError {
                            error = error1
                        }
                        if (error != nil) {
                            print("\(error?.localizedDescription)")
                        }
                        
                    }
                    
                }
                
            }
            cell?.orderDetailsLabel.text = "\(order.summary)"
            cell?.orderPriceLabel.text = "$\(order.price)"
            cell?.tableNoLabel.text = "Table #\(order.tableNo)"
            cell?.layer.borderWidth = 1.0
            cell?.layer.borderColor = UIColor.blueColor().CGColor
            cell?.layer.cornerRadius = 10.0
            return cell!
        default:
            return UITableViewCell()
        }
        
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 2.0
    }
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        
        if indexPath.section >= serviceArray.count{
            return true
        }
        return false
    }
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        let shareAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Complete", handler: {(action: UITableViewRowAction, indexPath: NSIndexPath) -> Void in
            
            let index = indexPath.section - self.serviceArray.count
            //TODO: Change order status
            
            self.processedOrderArray.append(self.orderArray[index])
            //self.processedOrderArray.sortInPlace{Int($0.0.orderNo) <= Int($0.1.orderNo)}
            self.orderArray.removeAtIndex(index)
            self.orderTableView.reloadData()
        
        })
        shareAction.backgroundColor = UIColor.greenColor()
        return [shareAction]
    }
    // MARK: - Segmented Control
    
    @IBAction func orderStatusSegmentedControlAction(sender: UISegmentedControl) {
        
        self.orderTableView.reloadData()

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
