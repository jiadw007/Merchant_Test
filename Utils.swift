//
//  Utils.swift
//  Merchant_Test
//
//  Created by FAWN on 15/12/8.
//  Copyright © 2015年 Talace. All rights reserved.
//

import Foundation
import UIKit

class Utils{


    class func createPopupAlertView(title: String!, message: String!, buttonTitle: String! ) -> UIAlertView{
        
        let alert = UIAlertView()
        
        alert.title = title
        alert.message   = message
        alert.addButtonWithTitle(buttonTitle)
        
        return alert
        
    }
    
    class func setTextFieldBorder(textField: UITextField){
        
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.lightGrayColor().CGColor
        border.frame = CGRect(x: 0, y: textField.frame.size.height - width, width : textField.frame.size.width, height: textField.frame.size.height)
        border.borderWidth  = width
        textField.layer.addSublayer(border)
        textField.layer.masksToBounds = true
        
    }
    

}

extension String {
    var doubleValue: Double? {
        if let number = NSNumberFormatter().numberFromString(self) {
            return number.doubleValue
        }
        return nil
    }
}