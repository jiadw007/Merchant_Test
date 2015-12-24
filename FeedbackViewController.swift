//
//  FeedbackViewController.swift
//  Merchant_Test
//
//  Created by FAWN on 15/12/23.
//  Copyright © 2015年 Talace. All rights reserved.
//

import UIKit

class FeedbackViewController: UIViewController {

    @IBOutlet weak var leaveMessageTextView: UITextView!
    
    @IBOutlet weak var leaveMessageTextField: UITextField!
    
    @IBOutlet weak var submitMessageButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // Mark: - TextField
    func textFieldDidBeginEditing(textField: UITextField) {
        textField.layer.zPosition = 1
        self.leaveMessageTextView.layer.zPosition = 0
        textField.text = self.leaveMessageTextView.text
    }
    func textFieldDidEndEditing(textField: UITextField) {
        
        self.leaveMessageTextView.text = textField.text
        if self.leaveMessageTextView.text != ""{
            
            textField.layer.zPosition = 0
            self.leaveMessageTextView.layer.zPosition = 1
        }
        
        
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    @IBAction func submitMessage(sender: UIButton) {
        self.leaveMessageTextField.endEditing(true)
        print(self.leaveMessageTextView.text)
        
    }
    
    @IBAction func dialOut(sender: AnyObject) {
        
        let alertController = UIAlertController(title: "1(352)2781628", message: "", preferredStyle: .Alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let dialAction = UIAlertAction(title: "Dial", style: UIAlertActionStyle.Default){ action in
            
            if let url = NSURL(string: "tel://1(352)2781628"){
                UIApplication.sharedApplication().openURL(url)
            }
            
        }
        alertController.addAction(dialAction)
        self.presentViewController(alertController, animated: true, completion: nil)
        
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
