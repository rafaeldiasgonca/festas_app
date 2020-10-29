//
//  ToDoTableViewCell.swift
//  festas_app
//
//  Created by Rafael Dias Gonçalves on 06/10/20.
//  Copyright © 2020 Rafael Dias Gonçalves. All rights reserved.
//

import UIKit

class ToDoTableViewCell: UITableViewCell {

    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var itensTF: UITextField!
    @IBOutlet weak var textFieldToDo: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        itensTF.isUserInteractionEnabled = false
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func checkButtonPressed(_ sender: UIButton) {
        if sender.isSelected{
            sender.isSelected = false
            textFieldToDo.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            
        }
        else{
            sender.isSelected = true
            checkButton.setImage(UIImage.checkmark, for: .normal)
            textFieldToDo.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        }

    }
    
}
