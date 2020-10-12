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
    var foodChurrasco = ["Decidir que Carnes usar","Mensurar quantidade de carnes","Comprar carnes","Decidir que tempero de carne usar","Comprar temperos","Comprar carvão"]
    var drinksChurrasco = ["Decidir que bebidas comprar","Comprar bebidas","Comprar gelo"]
    var utensilsChurrasco = ["Verificar se há amoladores","Verificar talheres","Verificar pegadores","Veridicar facas","Verificar tábuas"]
    var disponsableChurrasco = ["Verificar papel"]
    var spaceChurrasco = ["Verificar cadeiras","Alugar cadeiras","Verificar mesas","Alugar mesas","Verificar Local","Alugar local","Preparar local"]
    var foodNiver = ["Defina se cada um trará um prato","Defina se cada um trará uma sobremesa","Defina que prato você fará","Defina os aperitivos e petiscos","Compre os ingredientes para seu prato","Compre o(s) ingredientes para as sobremesa(s)","Compre os ingredientes para preparar os petiscos"]
    var drinksNiver = ["Defina os tipos de  bebida","Defina se cada um  trará uma bebida","Compre as bebidas","Coloque as bebidas para gelar no dia anterior","Organize as bebidas em um local de facil acesso"]
    var utensilsNiver = ["Defina as músicas","Cheque as restrições alimentícias de seus amigos","Cheque a afinidade entre seus convidados","Compre palitos de dente, guardanapos e outros utilitários","Compre os adereços","Defina o tema da festa"]
    var disponsableNiver = ["Separe pratos","Separe copos","Separe os talheres","Lave todas as louças que serão utilizadas"]
    var spaceNiver = ["Limpe o local","Limpe o(s) banheiro(s)","Prepare os banheiros para os convidados","Garanta o conforto do local","Defina como organizar o ambiente  de acordo com o tema"]
    var foodReuniao = ["Decida como vai ser o bolo","Encomende o bolo com antecedencia","Decida os salgadinhos","Compre os salgadinhos","Decida os docinhos","Compre os docinhos","Monte um cardápio","Compre ingredientes para os pratos(caso não haja buffet)","Decida se vai contratar um buffet","Decida se vai contratar um buffet"]
    var drinksReuniao = ["Defina todas as bebidas","Compre todas as bebidas","Certifique-se de gelar as bebidas no dia anterior"]
    var utensilsReuniao = ["Escolha o tema da festa","Defina o preço total da festa","Confirme todos os serviços contratados","Faça uma lista dos profissionais envolvidos","Defina as musicas","Decida os adereços utilizados","Compre os adereços","Compre balões"]
    var disponsableReuniao = ["Compre as velas","Compre ou alugue toalhas","adquira pratos","Compre guardanapos","Compre bandejas para doces e salgados","Decida sobre as atividades de festa","adquira copos","adquira talheres","Compre fita dupla face","Compre fósforos","Compre barbante"]
    var spaceReuniao = ["Cheque a estrutura do local","Cheque a disponibilidade das mesas e cadeiras","Garanta a limpeza do local","Prepare os banheiros para os convidados","Defina como organizar o ambiente  de acordo com o tema"]
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
