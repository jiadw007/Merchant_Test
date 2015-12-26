//
//  SigninViewController.swift
//  Merchant_Test
//
//  Created by FAWN on 15/12/25.
//  Copyright © 2015年 Talace. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var emailAddressTextField: UITextField!

    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var containerView: UIView!
    
    var scrollContentOffset: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.emailAddressTextField.attributedPlaceholder = NSAttributedString(string: "Email Address", attributes: [NSForegroundColorAttributeName : UIColor.lightGrayColor()])
        self.passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSForegroundColorAttributeName : UIColor.lightGrayColor()])
        Utils.setTextFieldBorder(self.emailAddressTextField)
        Utils.setTextFieldBorder(self.passwordTextField)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
        
    }
    
    deinit{
    
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func keyboardWillShow(notification: NSNotification){
    
        var info = notification.userInfo!
        var keyboardFrame = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
       
        self.scrollView.setContentOffset(CGPoint(x:0, y: keyboardFrame.size.height / 2), animated: true)
    
    }
    
    func keyboardWillHide(notification: NSNotification){
    
        var info = notification.userInfo!
        var keyboardFrame = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        
        self.scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func login(sender: AnyObject) {
        
        performSegueWithIdentifier("Success LogIn", sender: self)
    }
    
    @IBAction func forgotPassword(sender: UIButton) {
        
        
    }
    
    @IBAction func signUp(sender: UIButton) {
        
        
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
