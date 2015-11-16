//
//  ProductDetailsViewController.swift
//  Merchant_Test
//
//  Created by FAWN on 15/11/4.
//  Copyright © 2015年 Talace. All rights reserved.
//

import UIKit

class ProductDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    private struct ProductDetailsStoryBoard {
    
        static let EditItemSegueIdentifier = "editItem"
        static let cellReuseIdentifier = "reviewTableCell"
    }
    
    @IBOutlet weak var productImage: UIImageView!
    
    @IBOutlet weak var storeIcon: UIImageView!
    
    @IBOutlet weak var price: UILabel!
    
    @IBOutlet weak var originalPrice: UILabel!
    
    @IBOutlet weak var longerDescription: UILabel!
    
    @IBOutlet weak var reviewTableView: UITableView!
    
    @IBOutlet weak var averagePoints: UILabel!
    var product: Product!
    
    var rowNum: Int!
    
    var reviewArray = [Review]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        //TODO: Link review data
        let review_1 = Review(title: "Best Roll Ever", details: "I loved it", points: 4.8)
        let review_2 = review_1
        let review_3 = review_1
        reviewArray = [review_1, review_2, review_3]
        product.reviewArray = reviewArray
        
        //self.reviewTableView.reloadData()
        
        var reviewPointsSum = 0.0
        
        for review in reviewArray{
        
            reviewPointsSum += review.points
        
        }
        product.averReviewPoints = reviewPointsSum / Double(reviewArray.count)
        averagePoints.text = String(format: "%.1f", product.averReviewPoints)
        productImage.image = self.product.imageArray[0]
        price.text = "$\(product.price)"
        longerDescription.text = "Shrimp Tempura, Cucumber, Gobo Topped with Spicy Tuna, Tobiko, Green Onion, Unagi Source and Spicy Mayo"
        var attributedString = NSMutableAttributedString(string: "$ 21")
        attributedString.addAttributes([NSStrikethroughStyleAttributeName : 1], range: NSMakeRange(0, attributedString.length))
        originalPrice.attributedText = attributedString
        
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
        let cell = tableView.dequeueReusableCellWithIdentifier(ProductDetailsStoryBoard.cellReuseIdentifier, forIndexPath: indexPath) as! ReviewTableViewCell
        cell.customerImage.image = UIImage(named: "customer icon.jpeg")
        cell.reviewTitle.text = reviewArray[indexPath.row].reviewTitle
        cell.reviewDetails.text = reviewArray[indexPath.row].reviewDetails
        cell.reviewPoints.text = "\(reviewArray[indexPath.row].points)"
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
                dest.product = product
            
            }
        
        }
    }
    

}
