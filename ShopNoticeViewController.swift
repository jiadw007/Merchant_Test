//
//  ShopNoticeViewController.swift
//  Merchant_Test
//
//  Created by FAWN on 15/12/23.
//  Copyright © 2015年 Talace. All rights reserved.
//

import UIKit

class ShopNoticeViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var shopNoticeTextLabel: UILabel!
    
    @IBOutlet weak var shopNoticeTextView: UITextView!
    
    @IBOutlet weak var shopNoticeTextField: UITextField!
    
    @IBOutlet weak var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //shopNoticeTextView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Text Field
    func textFieldDidBeginEditing(textField: UITextField) {
        textField.layer.zPosition = 1
        self.shopNoticeTextView.layer.zPosition = 0
        textField.text = self.shopNoticeTextView.text
    }
    func textFieldDidEndEditing(textField: UITextField) {
        
        self.shopNoticeTextView.text = textField.text
        if self.shopNoticeTextView.text != ""{
        
            textField.layer.zPosition = 0
            self.shopNoticeTextView.layer.zPosition = 1
        }
        

    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    @IBAction func submitShopNotice(sender: UIButton) {
        self.shopNoticeTextField.endEditing(true)
        
        //TODO: Upload shop notice
        print(self.shopNoticeTextView.text)
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
