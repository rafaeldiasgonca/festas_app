//
//  ViewControllerListaDeConvidados.swift
//  festas_app
//
//  Created by Rafael Dias Gonçalves on 02/10/20.
//  Copyright © 2020 Rafael Dias Gonçalves. All rights reserved.
//

import UIKit
import CoreData

class ViewControllerListaDeConvidados: UIViewController {
    
    var guestList:[NSManagedObject] = []
    var convidados1 = 0
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func addGuestPressed(_ sender: UIBarButtonItem) {
        self.inserirNovoConvidado()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.deleteBlankSpace()
        //1
        guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        //2
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Guest")
        
        //3
        do {
            guestList = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        convidados1 = guestList.count
    }
    
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
            guestList.append(guest)
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

extension ViewControllerListaDeConvidados: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(guestList.count)
        return convidados1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier:"Convidados", for: indexPath) as! GuestsNamesTableViewCell
        cell.nameGuests.delegate = self
        cell.layer.cornerRadius = 12
        self.save(name: "")
        let person = guestList[indexPath.row]
        cell.nameGuests.text =  person.value(forKeyPath: "name") as? String
        
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let cell = tableView.cellForRow(at: indexPath) as! GuestsNamesTableViewCell
            guard let nameToDelete = cell.nameGuests.text else {return}
            self.delete(name: nameToDelete)
            if cell.nameGuests.text != "" {
                cell.nameGuests.text = ""
                cell.nameGuests.isEnabled = true
                cell.backgroundColor = .white
            }
            convidados1 = convidados1 - 1
            //numberOfGuests.text = String(convidados1)
            tableView.beginUpdates()
            tableView.deleteRows(at:[indexPath], with: .automatic)
            tableView.endUpdates()
            print(convidados1)
        }
    }
    func inserirNovoConvidado(){
        convidados1 = convidados1 + 1
        let indexPath = IndexPath.init(row: convidados1 - 1, section: 0)
        tableView.beginUpdates()
        tableView.insertRows(at:[indexPath], with:.automatic)
        for names in 0..<(convidados1-1) {
            print(guestList[names].value(forKeyPath: "name") as? String)
        }
        tableView.endUpdates()
        //numberOfGuests.text = String(convidados1)
    }
}

extension ViewControllerListaDeConvidados: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        var aux = 0
        let indexPath = IndexPath.init(row: convidados1, section: 0)
        tableView.cellForRow(at: indexPath)?.backgroundColor = .purple
        guard let nameToSave = textField.text else { return false }
        for empty in 0..<guestList.count {
            if aux == 0 {
                if guestList[empty].value(forKeyPath: "name") as? String == "" {
                    self.edit(index: empty, nome: nameToSave)
                    textField.text = ""
                    aux = 1
                }
            }
        }
        aux = 0
        tableView.reloadData()
        return  self.view.endEditing(true)
    }
    
}
