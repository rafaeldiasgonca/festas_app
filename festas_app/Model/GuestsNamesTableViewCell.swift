//
//  GuestsNamesTableViewCell.swift
//  festas_app
//
//  Created by Vinícius Pinheiro on 30/09/20.
//  Copyright © 2020 Rafael Dias Gonçalves. All rights reserved.
//

import UIKit

class GuestsNamesTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var nameGuests: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
