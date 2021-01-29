//
//  ToDoTableViewCell.swift
//  festas_app
//
//  Created by Rafael Dias Gonçalves on 06/10/20.
//  Copyright © 2020 Rafael Dias Gonçalves. All rights reserved.
//

import UIKit


protocol ChangeButton {
    func changeButton(checked:Bool, index:Int)
}


class ToDoTableViewCell: UITableViewCell{

    
    @IBOutlet weak var textViewToDo: UITextView!
    @IBOutlet weak var checkButton: UIButton!
    @IBAction func checkButtonPressed(_ sender: UIButton) {
        if food![indexP!].checked{
            delegate?.changeButton(checked: false, index: indexP!)
            
        }else{
            delegate?.changeButton(checked: true, index: indexP!)
        }
            
        }
    var delegate: ChangeButton?
    var indexP:Int?
    var food: [Task]?
            }


    


