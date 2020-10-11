//
//  ViewControllerModelos.swift
//  festas_app
//
//  Created by Rafael Dias Gonçalves on 22/09/20.
//  Copyright © 2020 Rafael Dias Gonçalves. All rights reserved.
//

import UIKit
import CoreData

var titulo = String()
class ModelsViewController: UIViewController {
    @IBOutlet weak var ViewChurrasco: UIView!
    @IBOutlet weak var ViewAniversario: UIView!
    @IBOutlet weak var ViewReuniaoDeAmigos: UIView!
    var modelName: NSManagedObject?
    
    let models = [3:"Reunião de amigos", 2:"Churrasco", 1:"Aniversário"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.deleteAllData(entity: "General")
//        self.deleteAllData(entity: "Food")
//        self.deleteAllData(entity: "Drinks")
//        self.deleteAllData(entity: "Space")
//        self.deleteAllData(entity: "Disposable")
//        self.deleteAllData(entity: "Utensils")
        ViewChurrasco.layer.cornerRadius = 12
        ViewReuniaoDeAmigos.layer.cornerRadius = 12
        ViewAniversario.layer.cornerRadius = 12
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
    
    
    func save(model: String) {
        
        guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        // 1
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        // 2
        let entity =
            NSEntityDescription.entity(forEntityName: "General",
                                       in: managedContext)!
        
        let modelType = NSManagedObject(entity: entity,
                                    insertInto: managedContext)
        
        // 3
        modelType.setValue(model, forKeyPath: "type")
        
        // 4
        do {
            try managedContext.save()
            modelName = modelType
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    @IBAction func modelTypePressed(_ sender: UIButton) {
        titulo = models[sender.tag]!
        self.save(model: titulo)
        print(titulo)
        self.performSegue(withIdentifier: "goToSettingsMenu", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let newVc:LocalDateViewController = segue.destination as! LocalDateViewController
        newVc.tituloRecebido = titulo
    }
    
}
