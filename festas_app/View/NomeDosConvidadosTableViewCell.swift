//
//  NomeDosConvidadosTableViewCell.swift
//  festas_app
//
//  Created by Rafael Dias Gonçalves on 26/09/20.
//  Copyright © 2020 Rafael Dias Gonçalves. All rights reserved.
//

import UIKit

class NomeDosConvidadosTableViewCell: UITableViewCell {

    @IBOutlet weak var NomeDosConvidadosTf: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
       createToolBar()
        
    }
    
    @IBAction func NomeDosConvidadosAC(_ sender: Any) {
        
    }
    func createToolBar(){
          
                     let toolbar = UIToolbar()
                     toolbar.sizeToFit()
                     let dnButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(dnbuttonPressed))
                     toolbar.setItems([dnButton], animated: true)
           NomeDosConvidadosTf.inputAccessoryView = toolbar
              
          }
       @objc func dnbuttonPressed(){
           let vc = ViewControllerConvidados()
        vc.convidados.append(NomeDosConvidadosTf.text ?? "")
        
              
          }
   
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
   

}
