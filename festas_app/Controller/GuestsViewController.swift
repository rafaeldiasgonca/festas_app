//
//  ViewControllerConvidados.swift
//  festas_app
//
//  Created by Rafael Dias Gonçalves on 24/09/20.
//  Copyright © 2020 Rafael Dias Gonçalves. All rights reserved.
//

import UIKit
import CoreData

class GuestsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var numberOfGuests: UILabel!
    var convidados1 = 1
    var convidados:[String] = []
    var guestList:[NSManagedObject] = []
    var nameIndex:Int? = nil
    var createCell = true
    @IBOutlet weak var ViewConvidados: UIView!
    var numDeConvidados = Int()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Guests"
        let gestureOneTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(endEditing(_:)))
        gestureOneTapRecognizer.numberOfTapsRequired = 1
        gestureOneTapRecognizer.numberOfTouchesRequired = 1
        self.view.addGestureRecognizer(gestureOneTapRecognizer)
        ViewConvidados.layer.cornerRadius = 12
        numberOfGuests.text = "0"
    }
    
    @objc func endEditing(_ gesture: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func completedButtonPressed(_ sender: UIButton) {
        for person in convidados {
            self.save(name: person)
        }
    }
    
    
    //MARK: - CoreData Functions
    
    func save(name: String) {
        
        guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        // 1
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        // 2
        let entity =
            NSEntityDescription.entity(forEntityName: "Guest",
                                       in: managedContext)!
        
        let guest = NSManagedObject(entity: entity,
                                    insertInto: managedContext)
        
        // 3
        guest.setValue(name, forKeyPath: "name")
        
        // 4
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func deleteBlankSpace(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: "Guest")
        requestDel.returnsObjectsAsFaults = false
        // If you want to delete data on basis of some condition then you can use NSPredicate
        let predicateDel = NSPredicate(format: "name = %@", "")
        requestDel.predicate = predicateDel
        
        
        do {
            let arrUsrObj = try context.fetch(requestDel)
            for usrObj in arrUsrObj as! [NSManagedObject] { // Fetching Object
                context.delete(usrObj) // Deleting Object
            }
        } catch {
            print("Failed")
        }
        
        // Saving the Delete operation
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
    }
    
    func delete(name: String){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: "Guest")
        requestDel.returnsObjectsAsFaults = false
        // If you want to delete data on basis of some condition then you can use NSPredicate
        let predicateDel = NSPredicate(format: "name = %@", name)
        requestDel.predicate = predicateDel
        
        
        do {
            let arrUsrObj = try context.fetch(requestDel)
            for usrObj in arrUsrObj as! [NSManagedObject] { // Fetching Object
                context.delete(usrObj) // Deleting Object
            }
        } catch {
            print("Failed")
        }
        
        // Saving the Delete operation
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
    }
    
    
    func edit(index: Int, nome: String){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: "Guest")
        requestDel.returnsObjectsAsFaults = false
        
        
        do {
            let arrUsrObj = try context.fetch(requestDel)
            let usrObj = arrUsrObj as! [NSManagedObject]
            usrObj[index].setValue(nome, forKey: "name")
            guestList[index] = usrObj[index]
            
        } catch {
            print("Failed")
        }
        
        // Saving the Delete operation
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
    }
    
    func deleteAllData(entity: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let results = try managedContext.fetch(fetchRequest)
            for managedObject in results {
                let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
                managedContext.delete(managedObjectData)
            }
        }
        catch let error as NSError {
            print("Delete all data in \(entity) error : \(error) \(error.userInfo)")
        }
    }
    
    
}


//MARK: - TableView Controller

extension GuestsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return convidados1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"Convidados", for: indexPath) as! GuestsNamesTableViewCell
        cell.nameGuests.delegate = self
        cell.layer.cornerRadius = 12
        cell.nameGuests.tag = indexPath.row
        
        if indexPath.row > 0 {
            if cell.nameGuests.text == "" {
                cell.nameGuests.becomeFirstResponder()
            }
        }
        
        
        if convidados.count > indexPath.row {
            let person = convidados[indexPath.row]
            cell.nameGuests.text = person
        } else {
            cell.nameGuests.text = ""
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let cell = tableView.cellForRow(at: indexPath) as! GuestsNamesTableViewCell
            if convidados.count > indexPath.row {
                convidados.remove(at: indexPath.row)
                
            }
            
            if cell.nameGuests.text != "" {
                cell.nameGuests.text = ""
                cell.nameGuests.isEnabled = true
                cell.backgroundColor = .white
            }
            
            if cell.nameGuests.text == "" {
                createCell = true
            }
            
            convidados1 = convidados1 - 1
            numberOfGuests.text = String(convidados.count)
            tableView.beginUpdates()
            tableView.deleteRows(at:[indexPath], with: .automatic)
            tableView.endUpdates()
        }
    }
    
    func inserirNovoConvidado(){
        convidados1 = convidados1 + 1
        
        
        tableView.beginUpdates()
        let indexPath = IndexPath.init(row: convidados1 - 1, section: 0)
        tableView.insertRows(at:[indexPath], with:.automatic)
        tableView.endUpdates()
        numberOfGuests.text = String(convidados1)
        
    }
}



//MARK: - TextField Controller

extension GuestsViewController: UITextViewDelegate, UITextFieldDelegate {
    
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let indexPath = IndexPath.init(row: convidados1 - 1, section: 0)
        
        guard let nameToSave = textField.text, !nameToSave.isEmpty else { return }
        
        if nameIndex != nil {
            convidados[nameIndex!] = nameToSave
            nameIndex = nil
        } else {
            convidados.append(nameToSave)
        }
        numberOfGuests.text = String(convidados.count)
        print("Os convidados são: \(convidados)")
        
        tableView.reloadData()
        
        if convidados1 > 1 && textField.text == "" {
            let cell = tableView.cellForRow(at: indexPath) as! GuestsNamesTableViewCell
            if convidados.count > indexPath.row {
                convidados.remove(at: indexPath.row)
            }
            
            if cell.nameGuests.text != "" {
                cell.nameGuests.text = ""
                cell.nameGuests.isEnabled = true
                cell.backgroundColor = .white
            }
            
            convidados1 = convidados1 - 1
            numberOfGuests.text = String(convidados.count)
            tableView.beginUpdates()
            tableView.deleteRows(at:[indexPath], with: .automatic)
            tableView.endUpdates()
        }
        
        
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        if convidados.count >= 0 {
            if textField.text != "" {
                for i in 0...convidados.count - 1 {
                    if convidados[i] == textField.text {
                        nameIndex = i
                    }
                }
            }
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField.text != "" && nameIndex == nil && createCell == false {
            self.view.endEditing(true)
            inserirNovoConvidado()
        }
        
        if createCell == true {
            createCell = false
            self.view.endEditing(true)
            inserirNovoConvidado()
        }

        numberOfGuests.text = String(convidados.count)
        return true
    }
}


