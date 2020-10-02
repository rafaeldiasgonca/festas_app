//
//  ViewControllerConvidados.swift
//  festas_app
//
//  Created by Rafael Dias Gonçalves on 24/09/20.
//  Copyright © 2020 Rafael Dias Gonçalves. All rights reserved.
//

import UIKit



class GuestsViewController: UIViewController,UITableViewDataSource,UITableViewDelegate, UITextViewDelegate, UITextFieldDelegate{
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var numberOfGuests: UILabel!
    var convidados1 = 1
    var convidados:[String] = []
    @IBOutlet weak var ViewConvidados: UIView!
    var numDeConvidados = Int()
    
    
    @IBOutlet weak var guestTextField: UITextField!
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
        let cell = tableView.cellForRow(at: indexPath) as! GuestsNamesTableViewCell
        if cell.nameGuests.text != "" {
            cell.nameGuests.text = ""
            cell.nameGuests.isEnabled = true
            cell.backgroundColor = .white
        }
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let indexPath = IndexPath.init(row: convidados1, section: 0)
        tableView.cellForRow(at: indexPath)?.backgroundColor = .purple
        textField.isEnabled = false
        convidados.append(textField.text!)
        print(convidados)
        tableView.reloadData()
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
            let cell = tableView.cellForRow(at: indexPath) as! GuestsNamesTableViewCell
            if cell.nameGuests.text != "" {
                convidados.remove(at: indexPath.row)
            }
           
            convidados1 = convidados1 - 1
            numberOfGuests.text = String(convidados1)
            tableView.beginUpdates()
            tableView.deleteRows(at:[indexPath], with: .automatic)
            tableView.endUpdates()
            print(convidados1)
        }
    }
    
}
