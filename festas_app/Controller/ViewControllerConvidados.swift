//
//  ViewControllerConvidados.swift
//  festas_app
//
//  Created by Rafael Dias Gonçalves on 24/09/20.
//  Copyright © 2020 Rafael Dias Gonçalves. All rights reserved.
//

import UIKit

class ViewControllerConvidados: UIViewController,UITableViewDataSource,UITableViewDelegate, UITextViewDelegate, UITextFieldDelegate{
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var numberOfGuests: UILabel!
    var convidados1 = 1
    var convidados:[String] = []
    @IBOutlet weak var ViewConvidados: UIView!
    
    var numDeConvidados = Int()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Convidados"
        ViewConvidados.layer.cornerRadius = 12
        numberOfGuests.text = String(convidados1)
        
    }
    
    
    @IBAction func addGuestPressed(_ sender: UIBarButtonItem) {
        inserirNovoConvidado()
    }
    
    @IBAction func ProsseguirButton(_ sender: Any) {
        print(convidados)
    }
    
    func inserirNovoConvidado(){
        convidados1 = convidados1 + 1
        let indexPath = IndexPath.init(row: convidados1 - 1, section: 0)
        tableView.beginUpdates()
        tableView.insertRows(at:[indexPath], with:.automatic)
        tableView.endUpdates()
        numberOfGuests.text = String(convidados1)
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let indexPath = IndexPath.init(row: convidados1 - 1, section: 0)
        tableView.cellForRow(at: indexPath)?.backgroundColor = .purple
        convidados.append(textField.text!)
        textField.isEnabled = false
        return  self.view.endEditing(true)
    
    }
        
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return convidados1
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"Convidados", for: indexPath) as! GuestsNamesTableViewCell
        cell.nameGuests.delegate = self
        cell.layer.cornerRadius = 12
        
        return cell
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            convidados1 = convidados1 - 1
            convidados.remove(at: indexPath.row)
            tableView.beginUpdates()
            tableView.deleteRows(at:[indexPath], with: .automatic)
            tableView.endUpdates()
            print(convidados1)
        }
    }
    
}
