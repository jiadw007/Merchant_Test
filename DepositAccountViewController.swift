//
//  DepositAccountViewController.swift
//  Merchant_Test
//
//  Created by FAWN on 15/12/23.
//  Copyright © 2015年 Talace. All rights reserved.
//

import UIKit

class DepositAccountViewController: UIViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "Checking" || segue.identifier == "Savings"{
            
            if let dest = segue.destinationViewController as? AccountDetailsViewController{
                let backItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
                navigationItem.backBarButtonItem = backItem
                dest.title = segue.identifier
                dest.account = segue.identifier
            }
        }
        
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
