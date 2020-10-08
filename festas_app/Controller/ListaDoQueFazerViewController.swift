//
//  ListaDoQueFazerViewController.swift
//  festas_app
//
//  Created by Rafael Dias Gonçalves on 02/10/20.
//  Copyright © 2020 Rafael Dias Gonçalves. All rights reserved.
//

import UIKit
import CoreData

class ListaDoQueFazerViewController: UIViewController {
    @IBOutlet weak var tableViewToDoList: UITableView!
    
    var cont  = 0
    var sectionNumber = 0
    var toDoList:[[NSManagedObject]] = [[]]
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.title = "Oque Fazer"
        
    }
    
    //Aqui tem comentário
    var churrascoToDo = [["Decidir que Carnes usar","Mensurar quantidade de carnes","Comprar carnes","Decidir que tempero de carne usar","Comprar temperos","Comprar carvão"],["Decidir que bebidas comprar","Comprar bebidas","Comprar gelo"],["Comprar copos","Comprar pratos","Comprar espetinhos","Comprar talheres"],["Verificar se há amoladores","Verificar talheres","Verificar pegadores","Veridicar facas","Verificar tábuas"],["Verificar cadeiras","Alugar cadeiras","Verificar mesas","Alugar mesas","Verificar Local","Alugar local","Preparar local"]]
    
    //MARK: - Core Data Functions
    
    func save(task: String, entityName: String, index:Int) {
        
        guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        // 1
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        // 2
        let entity =
            NSEntityDescription.entity(forEntityName: entityName,
                                       in: managedContext)!
        
        let toDoTask = NSManagedObject(entity: entity,
                                    insertInto: managedContext)
        
        // 3
        toDoTask.setValue(task, forKeyPath: "toDo")
        
        // 4
        do {
            try managedContext.save()
            toDoList[index].append(toDoTask)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func deleteBlankSpace(entity: String){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
             let context = appDelegate.persistentContainer.viewContext
             let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
             requestDel.returnsObjectsAsFaults = false
          // If you want to delete data on basis of some condition then you can use NSPredicate
             let predicateDel = NSPredicate(format: "toDo = %@", "")
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
    
    func delete(entity: String, toDoTask: String){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
             let context = appDelegate.persistentContainer.viewContext
             let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
             requestDel.returnsObjectsAsFaults = false
          // If you want to delete data on basis of some condition then you can use NSPredicate
             let predicateDel = NSPredicate(format: "toDo = %@", toDoTask)
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

    
    func edit(entity: String, index: Int, toDoTask: String, entityNumber: Int){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        requestDel.returnsObjectsAsFaults = false
        
        
        do {
            let arrUsrObj = try context.fetch(requestDel)
            let usrObj = arrUsrObj as! [NSManagedObject]
            usrObj[index].setValue(toDoTask, forKey: "toDo")
            toDoList[entityNumber][index] = usrObj[index]
            
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
        
//extension ListaDoQueFazerViewController: UITableViewDelegate, UITableViewDataSource {
//    
//}
