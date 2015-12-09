//
//  ItemAttTableViewCell.swift
//  Merchant_Test
//
//  Created by FAWN on 15/11/7.
//  Copyright © 2015年 Talace. All rights reserved.
//

import UIKit

class ItemAttTableViewCell: UITableViewCell, UITextFieldDelegate{

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var details: UILabel!
    @IBOutlet weak var detailsTextField: UITextField!
    
    var itemCategoryArray : [ItemCategory]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        detailsTextField.hidden = true

    }
    
    func detailsTapped(){
        
        
        if detailsTextField.tag != 3{
            details.hidden = true
            detailsTextField.hidden = false
            detailsTextField.text = details.text
           
        }
    }
    
    // - MARK: Textfield delegate
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        if textField.tag == 3{
            return false
            
        }
        return true
    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        
        if textField.tag == 2{
            
            var priceText: String!
        
            if detailsTextField.text?[(detailsTextField.text?.startIndex)!] != "$"{
            
                priceText = textField.text
            
            }else{
                
                priceText = textField.text?.substringFromIndex((textField.text!.startIndex).advancedBy(1))
            
            }
            
            if let value = priceText.doubleValue{
            
                detailsTextField.hidden = true
                details.hidden = false
                details.text = "$\(priceText)"
                return true
                
            }else{
            
                numberFormatAlert(textField)
                return false
            }
        }else{
            detailsTextField.hidden = true
            details.hidden = false
            details.text = detailsTextField.text
            
        }
        
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func numberFormatAlert(textField: UITextField){
        
        let alert = Utils.createPopupAlertView("Invalid \(textField.placeholder!)", message: "Please Enter Number.", buttonTitle: "Ok")
        alert.show()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
