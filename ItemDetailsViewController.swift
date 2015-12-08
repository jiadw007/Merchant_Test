//
//  ProductDetailsViewController.swift
//  Merchant_Test
//
//  Created by FAWN on 15/11/4.
//  Copyright © 2015年 Talace. All rights reserved.
//

import UIKit
import Parse

class ItemDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    private struct ItemDetailsStoryBoard {
    
        static let EditItemSegueIdentifier = "editItem"
        static let cellReuseIdentifier = "reviewTableCell"
    }
    
    @IBOutlet weak var itemImage: UIImageView!
    
    @IBOutlet weak var storeIcon: UIImageView!
    
    @IBOutlet weak var price: UILabel!
    
    @IBOutlet weak var originalPrice: UILabel!
    
    @IBOutlet weak var longerDescription: UILabel!
    
    @IBOutlet weak var reviewTableView: UITableView!
    
    @IBOutlet weak var averagePoints: UILabel!
    
    var item: Item!
    
    var itemPictureArray: [ItemPicture]!
    
    var rowNum: Int!
    
    var reviewArray = [Review]()
    
    var storeLogo : UIImage!
    
    @IBOutlet weak var storeLogoImageView: UIImageView!
    
    override func viewWillAppear(animated: Bool) {
        
        //TODO: Reload item
        item = MerchantDataService.reloadItem(item)
        self.navigationItem.title = item.name
        
        //TODO: Load all item pictures
        itemPictureArray = MerchantDataService.findAllItemPictureInItem(item).map{ItemPicture(pfObj: $0)}
        
        if itemPictureArray.count != 0{
            
            loadItemPicture(itemPictureArray[0])
        }
        price.text = "$\(item.price)"
        longerDescription.text = item.description
        let attributedString = NSMutableAttributedString(string: "$ 21")
        attributedString.addAttributes([NSStrikethroughStyleAttributeName : 1], range: NSMakeRange(0, attributedString.length))
        originalPrice.attributedText = attributedString
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        storeLogoImageView.image = storeLogo
        
        //TODO: Link review data
        
        
        //self.reviewTableView.reloadData()
        
//        var reviewPointsSum = 0.0
//        
//        for review in reviewArray{
//        
//            reviewPointsSum += review.points
//        
//        }
        //item.averReviewPoints = reviewPointsSum / Double(reviewArray.count)
        //averagePoints.text = String(format: "%.1f", product.averReviewPoints)
        
        
    }
    
    // MARK: - Load item picutre
    func loadItemPicture(itemPicture : ItemPicture){
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            
            var error:NSError? = nil
            do{
                
                let image = UIImage(data: try itemPicture.picture.getData())
                dispatch_async(dispatch_get_main_queue()) {
                    if true {
                        self.itemImage.image = image
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Review Table
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviewArray.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(ItemDetailsStoryBoard.cellReuseIdentifier, forIndexPath: indexPath) as! ReviewTableViewCell
        
        cell.userImage.image = UIImage(named: "customer icon.jpeg")
//        cell.reviewTitle.text = reviewArray[indexPath.row].reviewTitle
//        cell.reviewDetails.text = reviewArray[indexPath.row].reviewDetails
//        cell.reviewPoints.text = "\(reviewArray[indexPath.row].points)"
        return cell
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "editItem"{
        
            if let dest = segue.destinationViewController as? EditItemViewController{
                
                let backItem = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: dest, action: "backToParentViewController")
                dest.navigationItem.leftBarButtonItem = backItem
                dest.item = item
                dest.itemPictureArray = itemPictureArray
            }
        
        }
    }
    
    
    

}
