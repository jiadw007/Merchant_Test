////
////  OrderPageViewController.swift
////  Merchant_Test
////
////  Created by FAWN on 15/11/1.
////  Copyright © 2015年 Talace. All rights reserved.
////
//
//import UIKit
//
//class OrderPageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
//    
//    
//    @IBOutlet weak var searchBar: UISearchBar!
//
//    @IBOutlet weak var orderStatusSegmentControl: UISegmentedControl!
//    
//    @IBOutlet weak var orderTableView: UITableView!
//    
//    private var _alertTableCount: Int!
//    
//    private struct OrderPageStoryBoard{
//        
//        static let orderCellReuseIdentifier = "OrderTableCell"
//        static let alertCellReuseIdentifier = "AlertTableCell"
//        // TEST DATA
//        static var alertTableContent = [Alert]()
//        static var newOrderTableContent = [Order]()
//        static var processedOrderTableContent = [Order]()
//    }
//    override func viewWillAppear(animated: Bool) {
//        //self.orderTableView.estimatedRowHeight = 20
//        self.orderTableView.rowHeight = UITableViewAutomaticDimension
//    }
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        //self.orderTableView.contentInset = UIEdgeInsetsMake(0, 0, 100, 0)
//        // Test Data
//        // TODO: Link to order data
//        let order_1 = Order(orderNo: "23", orderTime: "2 minutes ago", customerName: "Kate", orderImage: UIImage(named:"Red Dragon Roll")!, orderDetails: "Dragon Roll and 2 other items...", orderPrice: "21.98", tableNo: "5")
//        let order_2 = Order(orderNo: "22", orderTime: "in 20 minutes", customerName: "Kevin", orderImage: UIImage(named:"Spicy Tuna")!, orderDetails: "Spicy Tuna Roll and 2 other items...", orderPrice: "39.99", tableNo: "4")
//        let alert_1 = Alert(alertImage: "Warning.png", alertTime: "Just Now", tableNo: "3", customerName: "Juaon Surname")
//        let alert_2 = Alert(alertImage: "Warning.png", alertTime: "1 Minute Ago", tableNo: "16", customerName: "Rebecca Blands")
//        let processed_order_1 = Order(orderNo: "19", orderTime: "6 minutes ago", customerName: "John", orderImage: UIImage(named:"Red Dragon Roll.png")!, orderDetails: "Dragon Roll", orderPrice: "9.99", tableNo: "6")
//        OrderPageStoryBoard.alertTableContent.append(alert_1)
//        OrderPageStoryBoard.alertTableContent.append(alert_2)
//        OrderPageStoryBoard.newOrderTableContent.append(order_1)
//        OrderPageStoryBoard.newOrderTableContent.append(order_2)
////        OrderPageStoryBoard.newOrderTableContent.sortInPlace({(first: Order, second: Order) in
////            return Int(first.orderNo) <= Int(second.orderNo)
////        })
//        OrderPageStoryBoard.newOrderTableContent.sortInPlace{Int($0.0.orderNo) <= Int($0.1.orderNo)}
//        OrderPageStoryBoard.processedOrderTableContent.append(processed_order_1)
//        _alertTableCount = OrderPageStoryBoard.alertTableContent.count
//        // Do any additional setup after loading the view.
//        self.orderTableView.reloadData()
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//    // MARK: - Table View
//    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        switch self.orderStatusSegmentControl.selectedSegmentIndex{
//            
//        case 0:
//            return OrderPageStoryBoard.newOrderTableContent.count + OrderPageStoryBoard.alertTableContent.count
//        case 2:
//            return OrderPageStoryBoard.processedOrderTableContent.count
//        default:
//            return 0
//        }
//    }
//    
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        switch self.orderStatusSegmentControl.selectedSegmentIndex{
//        case 0:
//            if indexPath.section < OrderPageStoryBoard.alertTableContent.count{
//        
//                return 30
//            }else{
//                return 92
//            }
//        default:
//            return 92
//        }
//    }
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        
//        switch self.orderStatusSegmentControl.selectedSegmentIndex{
//        case 0:
//            if indexPath.section >= _alertTableCount { //Order Table Cell
//                let cell = tableView.dequeueReusableCellWithIdentifier(OrderPageStoryBoard.orderCellReuseIdentifier, forIndexPath: indexPath) as? OrderTableCell
//                let order = OrderPageStoryBoard.newOrderTableContent[indexPath.section - _alertTableCount]
//                cell?.orderNoLabel.text = "Order # \(order.orderNo)"
//                cell?.orderTimeLabel.text = "\(order.orderTime)"
//                cell?.customerNameLabel.text = "\(order.customerName)"
//                cell?.orderImageView.image =  order.orderImage
//                cell?.orderDetailsLabel.text = "\(order.orderDetails)"
//                cell?.orderPriceLabel.text = "$\(order.orderPrice)"
//                cell?.tableNoLabel.text = "Table #\(order.tableNo)"
//                cell?.layer.borderWidth = 1.0
//                cell?.layer.borderColor = UIColor.blueColor().CGColor
//                cell?.layer.cornerRadius = 10.0
//                return cell!
//            }else{
//                
//                let cell = tableView.dequeueReusableCellWithIdentifier(OrderPageStoryBoard.alertCellReuseIdentifier, forIndexPath: indexPath) as? AlertTableCell
//                let alert = OrderPageStoryBoard.alertTableContent[indexPath.section]
//                cell?.alertImageView.image = UIImage(named: alert.alertImage)
//                cell?.alertTimeLabel.text = "\(alert.alertTime)"
//                cell?.tableNoLabel.text = "Table #\(alert.tableNo)"
//                cell?.customerNameLabel.text = "\(alert.customerName)"
//                cell?.layer.borderWidth = 1.0
//                cell?.layer.borderColor = UIColor.redColor().CGColor
//                cell?.layer.cornerRadius = 10.0
//                return cell!
//            }
//        case 2:
//            let cell = tableView.dequeueReusableCellWithIdentifier(OrderPageStoryBoard.orderCellReuseIdentifier, forIndexPath: indexPath) as? OrderTableCell
//            let order = OrderPageStoryBoard.processedOrderTableContent[indexPath.section]
//            cell?.orderNoLabel.text = "Order # \(order.orderNo)"
//            cell?.orderTimeLabel.text = "\(order.orderTime)"
//            cell?.customerNameLabel.text = "\(order.customerName)"
//            cell?.orderImageView.image = order.orderImage
//            cell?.orderDetailsLabel.text = "\(order.orderDetails)"
//            cell?.orderPriceLabel.text = "$\(order.orderPrice)"
//            cell?.tableNoLabel.text = "Table #\(order.tableNo)"
//            cell?.layer.borderWidth = 1.0
//            cell?.layer.borderColor = UIColor.blueColor().CGColor
//            cell?.layer.cornerRadius = 10.0
//            return cell!
//        default:
//            return UITableViewCell()
//        }
//        
//    }
//    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 2.0
//    }
//    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//        
//    }
//    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
//        
//        if indexPath.section >= _alertTableCount{
//            return true
//        }
//        return false
//    }
//    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
//        
//        let shareAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Complete", handler: {(action: UITableViewRowAction, indexPath: NSIndexPath) -> Void in
//            
//            let index = indexPath.section - self._alertTableCount
//            OrderPageStoryBoard.processedOrderTableContent.append(OrderPageStoryBoard.newOrderTableContent[index])
//            OrderPageStoryBoard.processedOrderTableContent.sortInPlace{Int($0.0.orderNo) <= Int($0.1.orderNo)}
//            OrderPageStoryBoard.newOrderTableContent.removeAtIndex(index)
//            self.orderTableView.reloadData()
//        
//        })
//        shareAction.backgroundColor = UIColor.greenColor()
//        return [shareAction]
//    }
//    // MARK: - Segmented Control
//    
//    @IBAction func orderStatusSegmentedControlAction(sender: UISegmentedControl) {
//        
//        self.orderTableView.reloadData()
//
//    }
//    
//    
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}
