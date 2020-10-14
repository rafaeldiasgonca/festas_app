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
    var foodChurrasco = ["Decide which Meat to use", "Measure the quantity of meat", "Buy meat", "Decide which meat seasoning to use", "Buy seasoning", "Buy charcoal"]
    var drinksChurrasco = ["Deciding which drinks to buy", "Buying drinks", "Buying ice"]
    var utensilsChurrasco = ["Check for sharpeners", "Check cutlery", "Check handles", "Check knives", "Check planks"]
    var disponsableChurrasco = ["Check paper"]
    var spaceChurrasco = ["Check chairs", "Rent chairs", "Check tables", "Rent tables", "Check place", "Rent place", "Prepare place"]
    var foodNiver = ["Define whether each will bring a dish", "Define whether each will bring a dessert", "Define which dish you will make", "Define appetizers and snacks", "Buy the ingredients for your dish", " Buy the dessert ingredients (s) "," Buy the ingredients to prepare the snacks "]
    var drinksNiver = ["Define the types of drinks", "Define if each one will bring a drink", "Buy the drinks", "Put the drinks to ice the previous day", "Organize the drinks in an easily accessible place" ]
    var utensilsNiver = ["Set the songs", "Check your friends' food restrictions", "Check the affinity between your guests", "Buy toothpicks, napkins and other utilities", "Buy the props", "Set the party theme "]
    var disponsableNiver = ["Separate plates", "Separate glasses", "Separate cutlery", "Wash all dishes that will be used"]
    var spaceNiver = ["Clean the place", "Clean the bathroom (s)", "Prepare the bathrooms for the guests", "Ensure the comfort of the place", "Define how to organize the room according to the theme "]
    var foodReuniao = ["Decide how the cake will be", "Order the cake in advance", "Decide the snacks", "Buy the snacks", "Decide the sweets", "Buy the sweets", "Set up a menu" , "Buy ingredients for the dishes (if there is no buffet)", "Decide whether to hire a buffet", "Decide whether to hire a buffet"]
    var drinksReuniao = ["Set all drinks", "Buy all drinks", "Make sure to chill the drinks the day before"]
    var utensilsReuniao = ["Choose the theme of the party", "Set the total price of the party", "Confirm all contracted services", "Make a list of the professionals involved", "Define the songs", "Decide the props used" , "Buy props", "Buy balloons"]
    var disponsableReuniao = ["Buy candles", "Buy or rent towels", "buy plates", "Buy napkins", "Buy trays for sweets and snacks", "Decide on party activities", "buy glasses", "buy cutlery", "buy double-sided tape", "buy matches", "buy string"]
    var spaceReuniao = ["Check the structure of the place", "Check the availability of tables and chairs", "Make sure the place is clean", "Prepare the bathrooms for the guests", "Define how to organize the room according to the theme "]
    var spaceToDo:[NSManagedObject] = []
    var foodToDo:[NSManagedObject] = []
    var drinksToDo:[NSManagedObject] = []
    var disponsableToDo:[NSManagedObject] = []
    var utensilsToDo:[NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.deleteAllData(entity: "General")
        self.deleteAllData(entity: "Food")
        self.deleteAllData(entity: "Drinks")
        self.deleteAllData(entity: "Space")
        self.deleteAllData(entity: "Disposable")
        self.deleteAllData(entity: "Utensils")
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
    
    func saveTask(task: String, entityName: String) {
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
        
        let taskToDo = NSManagedObject(entity: entity,
                                    insertInto: managedContext)
        
        // 3
        taskToDo.setValue(task, forKeyPath: "toDo")
        
        // 4
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func savePreToDoListFood(foodArray: [String], entityName: String) {
        for i in 0...foodArray.count - 1 {
            saveTask(task: foodArray[i], entityName: entityName)
        }
    }
    
    func savePreToDoListDrinks(drinkArray: [String], entityName: String) {
        for i in 0...drinkArray.count - 1 {
            saveTask(task: drinkArray[i], entityName: entityName)
        }
    }
    
    func savePreToDoListUtensils(utensilsArray: [String], entityName: String) {
        for i in 0...utensilsArray.count - 1 {
            saveTask(task: utensilsArray[i], entityName: entityName)
        }
    }
    
    func savePreToDoListDisponsable(disponsableArray: [String], entityName: String) {
        for i in 0...disponsableArray.count - 1 {
            saveTask(task: disponsableArray[i], entityName: entityName)
        }
    }
    
    func savePreToDoListSpace(spaceArray: [String], entityName: String) {
        for i in 0...spaceArray.count - 1 {
            saveTask(task: spaceArray[i], entityName: entityName)
        }
    }
    
    @IBAction func modelTypePressed(_ sender: UIButton) {
        titulo = models[sender.tag]!
        self.save(model: titulo)
        switch titulo {
        case "Aniversário":
            self.savePreToDoListFood(foodArray: foodNiver, entityName: "Food")
            self.savePreToDoListDrinks(drinkArray: drinksNiver, entityName: "Drinks")
            self.savePreToDoListUtensils(utensilsArray: utensilsNiver, entityName: "Utensils")
            self.savePreToDoListDisponsable(disponsableArray: disponsableNiver, entityName: "Disposable")
            self.savePreToDoListSpace(spaceArray: spaceNiver, entityName: "Space")
        case "Churrasco":
            self.savePreToDoListFood(foodArray: foodChurrasco, entityName: "Food")
            self.savePreToDoListDrinks(drinkArray: drinksChurrasco, entityName: "Drinks")
            self.savePreToDoListUtensils(utensilsArray: utensilsChurrasco, entityName: "Utensils")
            self.savePreToDoListDisponsable(disponsableArray: disponsableChurrasco, entityName: "Disposable")
            self.savePreToDoListSpace(spaceArray: spaceChurrasco, entityName: "Space")
        case "Reunião de Amigos":
            self.savePreToDoListFood(foodArray: foodReuniao, entityName: "Food")
            self.savePreToDoListDrinks(drinkArray: drinksReuniao, entityName: "Drinks")
            self.savePreToDoListUtensils(utensilsArray: utensilsReuniao, entityName: "Utensils")
            self.savePreToDoListDisponsable(disponsableArray: disponsableReuniao, entityName: "Disposable")
            self.savePreToDoListSpace(spaceArray: spaceReuniao, entityName: "Space")
        default:
            print("Erro!")
        }
        print()
        self.performSegue(withIdentifier: "goToSettingsMenu", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let newVc:LocalDateViewController = segue.destination as! LocalDateViewController
        newVc.tituloRecebido = titulo
    }
    
}
