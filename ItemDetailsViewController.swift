//
//  ProductDetailsViewController.swift
//  Merchant_Test
//
//  Created by FAWN on 15/11/4.
//  Copyright © 2015年 Talace. All rights reserved.
//

import UIKit
import Parse
import EDStarRating

class ItemDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    

    
    private struct ItemDetailsStoryBoard {
    
        static let EditItemSegueIdentifier = "editItem"
        static let cellReuseIdentifier = "itemReviewTableCell"
    }
    
    @IBOutlet weak var itemImage: UIImageView!
    
    @IBOutlet weak var storeIcon: UIImageView!
    
    @IBOutlet weak var price: UILabel!
    
    @IBOutlet weak var originalPrice: UILabel!
    
    @IBOutlet weak var longerDescription: UILabel!
    
    @IBOutlet weak var reviewTableView: UITableView!
    
    @IBOutlet weak var averagePoints: UILabel!
    
    
    @IBOutlet weak var starRating: EDStarRating!
    
    
    var item: Item!
    
    var itemPictureArray = [ItemPicture]()
    
    var itemCategoryArray = [ItemCategory]()
    
    var rowNum: Int!
    
    var itemReviewArray = [ItemReview]()
    
    var storeLogo : UIImage!
    
    @IBOutlet weak var storeLogoImageView: UIImageView!
    
    override func viewWillAppear(animated: Bool) {
        
        
        //Rating Star
        self.starRating.backgroundColor = UIColor.whiteColor()
        self.starRating.starImage = UIImage(named: "star-template")
        self.starRating.starImage = self.starRating.starImage
        self.starRating.starHighlightedImage = UIImage(named: "star-highlighted-template")
        
        self.starRating.maxRating = 5;
        self.starRating.editable = false
        //self.starRating.horizontalMargin = 25.0
        //self.starRating.delegate = self
        
        self.starRating.displayMode = UInt(EDStarRatingDisplayHalf)
        self.starRating.tintColor = UIColor.blueColor()
        
        loadItem()
        
        

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        storeLogoImageView.image = storeLogo
        
        //self.reviewTableView.reloadData()
        
    }
    
    // MARK: - PFQuery Function
    func loadItem(){
    
        //TODO: Reload item
        let query = Item.query()
        
        query?.getObjectInBackgroundWithId(self.item.objectId!){ (object: PFObject?, error: NSError?) -> Void in
        
            
            if error == nil{
            
                if let item = object as? Item{
                
                    self.item = item
                    self.loadAllItemPicture()
                    self.loadAllItemReview()
                
                    self.price.text = "$\(item.price)"
                    self.longerDescription.text = item.summary
                    let discount = item.discount
                        
                    if discount != 0.0{
                    
                        let attributedString = NSMutableAttributedString(string: "$\(item.price)")
                        attributedString.addAttributes([NSStrikethroughStyleAttributeName : 1], range: NSMakeRange(0, attributedString.length))
                        self.originalPrice.attributedText = attributedString
                        self.originalPrice.hidden = false
                        self.price.text = String(format: "%.1f", item.price * discount)
                    }else{
                    
                        self.originalPrice.hidden = true
                    
                    }
                    self.navigationItem.title = item.name

                }
            
            
            }
        
        }
    
    }
    
    func loadAllItemPicture(){
    
        let query = ItemPicture.query()!
        query.whereKey("item", equalTo: self.item)
        query.includeKey("item.category.store.category")
        query.includeKey("item.store.category")
        query.orderByDescending("updatedAt")
        query.findObjectsInBackgroundWithBlock{(objects: [PFObject]?, error: NSError? ) -> Void in
        
            if error == nil{
            
                if let objects = objects as? [ItemPicture]{
                
                    self.itemPictureArray = objects
                    if self.itemPictureArray.count != 0{
                    
                        self.loadItemPicture(self.itemPictureArray[0])
                    
                    }
                }
            
            
            }else{
            
                print("Error: \(error!) \(error!.debugDescription)")
            
            }
        
        
        }
    
    }

    func loadAllItemReview(){
        
        let query = ItemReview.query()!
        query.whereKey("item", equalTo: self.item)
        query.includeKey("item.category.store.category")
        query.includeKey("item.store.category")
        query.orderByDescending("updatedAt")
        query.findObjectsInBackgroundWithBlock{(objects: [PFObject]?, error: NSError? ) -> Void in
        
            if error == nil{
            
            
                if let objects = objects as? [ItemReview]{
                
                    self.itemReviewArray = objects
                    
                    var reviewPointsSum = 0.0
                    
                    for review in self.itemReviewArray{
                        
                        reviewPointsSum += Double(review.rating)
                        
                    }
                    self.averagePoints.text = String(format: "%.1f", reviewPointsSum / Double(self.itemReviewArray.count))
                    self.starRating.rating = Float(self.averagePoints.text!)!
                    self.starRating.setNeedsDisplay()
                    self.reviewTableView.reloadData()
                }
            
            
            
            }else{
            
                print("Error: \(error!) \(error!.debugDescription)")
            
            
            }
        
        }
    
    
    }
    
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
        return itemReviewArray.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(ItemDetailsStoryBoard.cellReuseIdentifier, forIndexPath: indexPath) as! ItemReviewTableViewCell
        
        let review = itemReviewArray[indexPath.row]
        
        let query = PFUser.query()!
        query.whereKey("objectId", equalTo: review.user.objectId!)
        query.orderByDescending("updatedAt")
        query.getFirstObjectInBackgroundWithBlock{ (object: PFObject?, error: NSError?) -> Void in
        
            if error == nil{
            
                if let object = object as? PFUser{
                
                    let imageFile = object.valueForKey("profilePic") as! PFFile
                    var error:NSError? = nil
                    do{
                        let image = UIImage(data: try imageFile.getData())
                        cell.userImage.image = image
                    }catch let error1 as NSError {
                        error = error1
                    }
                    if (error != nil) {
                        print("\(error?.localizedDescription)")
                    }
                
                }
            
            }else{
            
                print("\(error?.localizedDescription)")
            
            }
        
        }
        cell.reviewTitle.text = review.content
        cell.reviewDetails.text = review.content
        cell.reviewPoints.text = "\(review.rating)"
        cell.starRating.rating = review.rating
        cell.starRating.setNeedsDisplay()
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
                dest.itemCategoryArray = itemCategoryArray
            }
        
        }
    }
    
    
    

}
