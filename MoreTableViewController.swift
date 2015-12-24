//
//  MoreTableViewController.swift
//  Merchant_Test
//
//  Created by FAWN on 15/11/1.
//  Copyright © 2015年 Talace. All rights reserved.
//

import UIKit

class MoreTableViewController: UITableViewController {
    
    private struct MoreTableStoryBoard{
    
        static let staticTestData = ["Loyalty Customer List", "Reward/Loyalty Program", "Deposit Account", "Businees Info", "Employees", "Merchant Notice", "Help & Feedback","Log Out"]
        static let cellReuseIdentifier = "MoreTableCell"
        
    
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return MoreTableStoryBoard.staticTestData.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(MoreTableStoryBoard.cellReuseIdentifier, forIndexPath: indexPath)

        // Configure the cell...
        cell.textLabel?.text = MoreTableStoryBoard.staticTestData[indexPath.row]
        
        return cell
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        performSegueWithIdentifier((cell?.textLabel?.text)!, sender: self)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "Merchant Notice"{
        
            if let dest = segue.destinationViewController  as? ShopNoticeViewController{
            
                let backItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
                navigationItem.backBarButtonItem = backItem
                dest.title = segue.identifier
            
            }
        
        } else if segue.identifier == "Help & Feedback"{
        
            if let dest = segue.destinationViewController  as? FeedbackViewController{
                
                let backItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
                navigationItem.backBarButtonItem = backItem
                dest.title = segue.identifier
                
            }
        
        } else if segue.identifier == "Deposit Account"{
            
            if let dest = segue.destinationViewController  as? DepositAccountViewController{
                
                let backItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
                navigationItem.backBarButtonItem = backItem
                dest.title = segue.identifier
                
            }
            
        } else if segue.identifier == "Loyalty Customer List"{
            
            if let dest = segue.destinationViewController  as? LoyaltyCustomerTableViewController{
                
                let backItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
                navigationItem.backBarButtonItem = backItem
                dest.title = segue.identifier
                
            }
            
        }else if segue.identifier == "Reward/Loyalty Program"{
            
            if let dest = segue.destinationViewController  as? RewardsViewController{
                
                let backItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
                navigationItem.backBarButtonItem = backItem
                dest.title = segue.identifier
                
            }
            
        }
        
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
