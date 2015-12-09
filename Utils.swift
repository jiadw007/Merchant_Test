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
    

}

extension String {
    var doubleValue: Double? {
        if let number = NSNumberFormatter().numberFromString(self) {
            return number.doubleValue
        }
        return nil
    }
}