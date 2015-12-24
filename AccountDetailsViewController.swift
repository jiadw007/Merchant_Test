//
//  AccountDetailsViewController.swift
//  Merchant_Test
//
//  Created by FAWN on 15/12/23.
//  Copyright © 2015年 Talace. All rights reserved.
//

import UIKit

class AccountDetailsViewController: UIViewController, UITextFieldDelegate {
    
    var account: String!
    
    @IBOutlet weak var routingNumberTextField: UITextField!
    
    @IBOutlet weak var accountNumberTextField: UITextField!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var submitAccountButton: UIButton!
    
    var routingNumber : Int!
    
    var accountNumber : Int!
    
    var scrollContentOffset: CGPoint!
    
    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "rotated", name: UIDeviceOrientationDidChangeNotification, object: nil)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func rotated(){
        
        //self.scrollContentOffset = scrollView.contentOffset
        if UIDeviceOrientationIsLandscape(UIDevice.currentDevice().orientation){
        
            var scrollPoint = CGPointMake(0, self.routingNumberTextField.frame.origin.y - 40)
            scrollView.setContentOffset(scrollPoint, animated: true)
        }
        
        if UIDeviceOrientationIsPortrait(UIDevice.currentDevice().orientation){
            
            var scrollPoint = CGPointMake(0, self.routingNumberTextField.frame.origin.y - 90)
            scrollView.setContentOffset(scrollPoint, animated: true)
        
        }
    
    }
    
    @IBAction func submitAccount(sender: UIButton) {
        
        
    }
    
    // MARK: - Text Field
    
    func textFieldDidBeginEditing(textField: UITextField) {
        let view_width = view.frame.size.width
        let view_height = view.frame.size.height
        self.scrollContentOffset = scrollView.contentOffset
        var scrollPoint: CGPoint!
        
        if view_height > view_width { // portrait
        
            scrollPoint = CGPointMake(0, self.routingNumberTextField.frame.origin.y - 90)
            scrollView.setContentOffset(scrollPoint, animated: true)
        }else{
        
            scrollPoint = CGPointMake(0, self.routingNumberTextField.frame.origin.y - 40)
            scrollView.setContentOffset(scrollPoint, animated: true)
        }
        
        
    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        if textField.text == "" {
            scrollView.setContentOffset(self.scrollContentOffset, animated: true)
            return true
        }
        
        switch textField.tag {
        
        case 0:
            if let number = Int(textField.text!){
                routingNumber = number
                scrollView.setContentOffset(self.scrollContentOffset, animated: true)
                return true
            }else{
                let alertView = Utils.createPopupAlertView("Invalid \(textField.placeholder!)", message: "", buttonTitle: "Ok")
                alertView.show()
                return false
            }
        case 1:
            
            if let number = Int(textField.text!){
                accountNumber = number
                scrollView.setContentOffset(self.scrollContentOffset, animated: true)
                return true
            }else{
                let alertView = Utils.createPopupAlertView("Invalid \(textField.placeholder!)", message: "", buttonTitle: "Ok")
                alertView.show()
                return false
            }
        default:
            scrollView.setContentOffset(self.scrollContentOffset, animated: true)

            return true
        }
        //return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
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
