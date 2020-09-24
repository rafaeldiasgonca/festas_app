//
//  ViewControllerConvidados.swift
//  festas_app
//
//  Created by Rafael Dias Gonçalves on 24/09/20.
//  Copyright © 2020 Rafael Dias Gonçalves. All rights reserved.
//

import UIKit

class ViewControllerConvidados: UIViewController,UITableViewDataSource{
    
    
  
    let azul =  ["abc","abcd"]

    @IBOutlet weak var ViewConvidados: UIView!
    @IBOutlet weak var textFieldConvidados: UITextField!
    var numDeConvidados = Int()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Convidados"
        ViewConvidados.layer.cornerRadius = 12
        textFieldConvidados.layer.cornerRadius = 8
        btnNumberPad()
        
    }
    
    func btnNumberPad(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let dnButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action:#selector(dnButtonPressed))
        toolbar.setItems([dnButton], animated: true)
        textFieldConvidados.inputAccessoryView = toolbar
    }
   @objc func dnButtonPressed(){
    
    
        self.view.endEditing(true)
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let textoConvertido = Int(textFieldConvidados.text)
        
          return textoConvertido
      }
      
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"Convidados", for: indexPath)
        return cell
      }
    
    
}
