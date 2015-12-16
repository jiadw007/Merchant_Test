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
        
        
        if detailsTextField.tag != 4{
            details.hidden = true
            detailsTextField.hidden = false
            detailsTextField.text = details.text
           
        }
    }
    
    // - MARK: Textfield delegate
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        if textField.tag == 4{
            return false
            
        }
        return true
    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        switch textField.tag{
        
        
        case 2:
            var priceText: String!
            
            if textField.text?[(textField.text?.startIndex)!] != "$"{
                
                priceText = textField.text
                
            }else{
                
                priceText = textField.text?.substringFromIndex((textField.text!.startIndex).advancedBy(1))
                
            }
            
            if let value = priceText.doubleValue{
                if value > 0 {
                    textField.hidden = true
                    details.hidden = false
                    details.text = "$\(priceText)"
                    return true
                }else{
                    
                    invalidValueAlert(textField, message: "Price > 0")
                
                }
                
            }else{
                
                numberFormatAlert(textField)
                return false
            }
        case 3:
            if let value = textField.text?.doubleValue{
                if value <= 1.0 && value >= 0.0 {
                
                    textField.hidden = true
                    details.hidden = false
                    details.text = "\(value)"
                    return true
                
                }else{
                    
                    invalidValueAlert(textField, message: "Discount range 0 - 1")
                    return false
                }
            
            }else{
                numberFormatAlert(textField)
                return false
            
            }
        default:
            
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
    func invalidValueAlert(textField: UITextField, message: String){
    
        let alert = Utils.createPopupAlertView("Invalid \(textField.placeholder!)", message: message, buttonTitle: "Ok")
        alert.show()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
