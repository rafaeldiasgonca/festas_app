//
//  ToDoTableViewCell.swift
//  festas_app
//
//  Created by Rafael Dias Gonçalves on 06/10/20.
//  Copyright © 2020 Rafael Dias Gonçalves. All rights reserved.
//

import UIKit

class ToDoTableViewCell: UITableViewCell {

    @IBOutlet weak var CheckButton: UIButton!
    @IBOutlet weak var itensTF: UITextField!
    @IBOutlet weak var textFieldToDo: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
