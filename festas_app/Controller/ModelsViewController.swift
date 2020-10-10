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
    
    let models = [1:"Reuniao de amigos", 2:"Churrasco", 3:"Aniversario"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ViewChurrasco.layer.cornerRadius = 12
        ViewReuniaoDeAmigos.layer.cornerRadius = 12
        ViewAniversario.layer.cornerRadius = 12
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
        print(modelName)
        self.performSegue(withIdentifier: "goToSettingsMenu", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let newVc:SettingsViewController = segue.destination as! SettingsViewController
        newVc.tituloRecebido = titulo
    }
    
}
