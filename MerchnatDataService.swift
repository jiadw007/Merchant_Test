//
//  MerchnatDataService.swift
//  Merchant_Test
//
//  Created by FAWN on 15/12/2.
//  Copyright © 2015年 Talace. All rights reserved.
//

import Foundation
import Fabric
import Parse
import Stripe
import Crashlytics

class MerchantDataService {
    
    private struct Constants {
    
        static let ParseApplicationID = "by3yCcO7hzhPU5bys8MY1v9FRGtj0iReN3R7ZW2R"
        static let ParseClientKey = "VPzb9RsxNZjlf4XFJ2idLP6STI1AtTLEoU4vpkxy"
    
    }

    class func setEnv(){
    
        Parse.setApplicationId(Constants.ParseApplicationID, clientKey: Constants.ParseClientKey)
        //Stripe.setDefaultPublishableKey()
        Fabric.with([Crashlytics()])
    
    }




}
