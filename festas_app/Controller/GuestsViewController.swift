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
    @IBOutlet weak var ViewConvidados: UIView!
    var numDeConvidados = Int()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Convidados"
        ViewConvidados.layer.cornerRadius = 12
        numberOfGuests.text = String(convidados1)
        self.save(name: "")
    }
    
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      
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
    }

    
    @IBAction func addGuestPressed(_ sender: UIBarButtonItem) {
        inserirNovoConvidado()
    }
    
    @IBAction func ProsseguirButton(_ sender: Any) {
        print(convidados)
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
        guestList.append(guest)
      } catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
      }
    }
    
    func delete(index: Int){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: "Guest")
        requestDel.returnsObjectsAsFaults = false
        
        
        do {
            let arrUsrObj = try context.fetch(requestDel)
            let usrObj = arrUsrObj as! [NSManagedObject]
            context.delete(usrObj[index])
            
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
        let person = guestList[indexPath.row]
        cell.nameGuests.text =  person.value(forKeyPath: "name") as? String
        return cell
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let cell = tableView.cellForRow(at: indexPath) as! GuestsNamesTableViewCell
            if cell.nameGuests.text != "" {
                //convidados.remove(at: indexPath.row)
            }
            if cell.nameGuests.text != "" {
                cell.nameGuests.text = ""
                cell.nameGuests.isEnabled = true
                cell.backgroundColor = .white
            }
            self.delete(index: indexPath.row)
            convidados1 = convidados1 - 1
            numberOfGuests.text = String(convidados1)
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
        numberOfGuests.text = String(convidados1)
    }
}



//MARK: - TextField Controller

extension GuestsViewController: UITextViewDelegate, UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let indexPath = IndexPath.init(row: convidados1, section: 0)
        tableView.cellForRow(at: indexPath)?.backgroundColor = .purple
        textField.isEnabled = false
        guard let nameToSave = textField.text else { return false }
        self.edit(index: convidados1-1, nome: nameToSave)
        convidados.append(nameToSave)
        print(convidados)
        tableView.reloadData()
        return  self.view.endEditing(true)
    }
    
}

