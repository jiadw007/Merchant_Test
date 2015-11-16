//
//  ItemAttTableViewCell.swift
//  Merchant_Test
//
//  Created by FAWN on 15/11/7.
//  Copyright © 2015年 Talace. All rights reserved.
//

import UIKit

class ItemAttTableViewCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var details: UILabel!
    @IBOutlet weak var detailsTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        detailsTextField.hidden = true
        details.userInteractionEnabled = true
        let aSelector :Selector = "detailsTapped"
        let tapGesture = UITapGestureRecognizer(target: self, action: aSelector)
        tapGesture.numberOfTapsRequired = 1
        details.addGestureRecognizer(tapGesture)
    }
    
    func detailsTapped(){
    
        details.hidden = true
        detailsTextField.hidden = false
        detailsTextField.text = details.text
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        detailsTextField.hidden = true
        details.hidden = false
        if textField.tag == 2 && detailsTextField.text?[(detailsTextField.text?.startIndex)!] != "$"{
            details.text = "$\(detailsTextField.text!)"
        }else{
            details.text = detailsTextField.text
        }
        return true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
