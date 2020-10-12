//
//  ListaDoQueFazerViewController.swift
//  festas_app
//
//  Created by Rafael Dias Gonçalves on 02/10/20.
//  Copyright © 2020 Rafael Dias Gonçalves. All rights reserved.
//

import UIKit
import CoreData

class ToDoListViewController: UIViewController {
    @IBOutlet weak var tableViewToDoList: UITableView!
    var a = 0
    var cont  = 0
    var aux = 0
    var modelNumber = 0
    var cellTag = 0
    var checkRow = 0
    var checkSection = 0
    var type:EventType = .none
    var sectionInEdit:Section = .none
    var foodList:[String] = []
    var drinksList:[String] = []
    var disposableList:[String] = []
    var spaceList:[String] = []
    var utensilsList:[String] = []
    
    enum Section:Int {
        case comida = 0
        case bebidas
        case descartáveis
        case utensílios
        case espaço
        case none
        
        var title:String {
            switch self {
            case .comida:
                return "Food"
            case .bebidas:
                return "Drinks"
            case .descartáveis:
                return "Disposable"
            case .utensílios:
                return "Utensils"
            case .espaço:
                return "Space"
            case .none:
                return ""
            }
        }
    }
    
    enum EventType:String {
        case aniversário = "Aniversário"
        case churrasco = "Churrasco"
        case reuniao = "Reunião de amigos"
        case none = ""
//
//        func getArray() -> [[String]] {
//            switch self {
//            case .aniversário:
//                return [foodNiver,drinksNiver,utensilsNiver,disponsableNiver, spaceNiver]
//            case .churrasco:
//                return [foodChurrasco,drinksChurrasco,utensilsChurrasco,disponsableChurrasco, spaceChurrasco]
//            case .reuniao:
//                return [foodReuniao, drinksReuniao, utensilsReuniao, disponsableReuniao,spaceReuniao]
//            case .none:
//                return []
//            }
//        }
        


        
    }

     
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Oque Fazer"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadModelType()
        self.deleteBlankSpace(entity: "Food")
        self.deleteBlankSpace(entity: "Drinks")
        self.deleteBlankSpace(entity: "Space")
        self.deleteBlankSpace(entity: "Disposable")
        self.deleteBlankSpace(entity: "Utensils")
        self.loadDataFood()
        self.loadDataSpace()
        self.loadDataDrinks()
        self.loadDataDisposable()
        self.loadDataUtensils()
        print(foodList)
    }
    
    
    //MARK: - Core Data Functions
    
    func loadDataFood() {
        //1
        guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        //2
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Food")
        
        //3
        do {
            let results = try managedContext.fetch(fetchRequest)
            for i in 0...results.count - 1 {
                let element = results[i].value(forKey: "toDo") as? String ?? ""
                foodList.append(element)
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func loadDataDrinks() {
        //1
        guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        //2
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Drinks")
        
        //3
        do {
            let results = try managedContext.fetch(fetchRequest)
            for i in 0...results.count - 1 {
                let element = results[i].value(forKey: "toDo") as? String ?? ""
                drinksList.append(element)
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func loadDataUtensils() {
        //1
        guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        //2
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Utensils")
        
        //3
        do {
            let results = try managedContext.fetch(fetchRequest)
            for i in 0...results.count - 1 {
                let element = results[i].value(forKey: "toDo") as? String ?? ""
                utensilsList.append(element)
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func loadDataDisposable() {
        //1
        guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        //2
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Disposable")
        
        //3
        do {
            let results = try managedContext.fetch(fetchRequest)
            for i in 0...results.count - 1 {
                let element = results[i].value(forKey: "toDo") as? String ?? ""
                disposableList.append(element)
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func loadDataSpace() {
        //1
        guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        //2
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Space")
        
        //3
        do {
            let results = try managedContext.fetch(fetchRequest)
            for i in 0...results.count - 1 {
                let element = results[i].value(forKey: "toDo") as? String ?? ""
                spaceList.append(element)
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    
    
    
    func loadModelType() {
        //1
        guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        //2
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "General")
        
        //3
        var typeName = String()
        do {
            let results = try managedContext.fetch(fetchRequest)
            for i in 0...results.count - 1 {
                if results[i].value(forKey: "type") != nil {
                    typeName = results[i].value(forKey: "type") as! String
                }
            }
            guard let type = EventType.init(rawValue: typeName) else {return}
            self.type = type
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func save(task: String, entityName: String, section: Int) {
        
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
//            switch section {
//            case 0:
//                foodList.append(toDoTask)
//            case 1:
//                drinksList.append(toDoTask)
//            case 2:
//                utensilsList.append(toDoTask)
//            case 3:
//                disposableList.append(toDoTask)
//            case 4:
//                spaceList.append(toDoTask)
//            default:
//                print("Erro!")
//            }
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
    
    
//    func edit(entity: String, index: Int, toDoTask: String, entityNumber: Int){
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let context = appDelegate.persistentContainer.viewContext
//        let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
//        requestDel.returnsObjectsAsFaults = false
//
//
//        do {
//            let arrUsrObj = try context.fetch(requestDel)
//            let usrObj = arrUsrObj as! [NSManagedObject]
//            usrObj[index].setValue(toDoTask, forKey: "toDo")
//            foodList[index] = usrObj[index]
//
//        } catch {
//            print("Failed")
//        }
//
//        // Saving the Delete operation
//        do {
//            try context.save()
//        } catch {
//            print("Failed saving")
//        }
//    }
    
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

extension ToDoListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sectionType = Section.init(rawValue: section) else { return 0 }
        switch sectionType {
        case .comida:
            return foodList.count-1
        case .bebidas:
            return drinksList.count-1
        case .utensílios:
            return utensilsList.count-1
        case .descartáveis:
            return disposableList.count-1
        case .espaço:
            return spaceList.count-1
        case .none:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ToDoTableViewCell
        guard let sectionType = Section.init(rawValue: indexPath.section) else { return .init() }
        switch sectionType {
        case .comida:
            cell.textFieldToDo.text = foodList[indexPath.row]
        case .bebidas:
            cell.textFieldToDo.text = drinksList[indexPath.row]
        case .utensílios:
            cell.textFieldToDo.text = utensilsList[indexPath.row]
        case .descartáveis:
            cell.textFieldToDo.text = disposableList[indexPath.row]
        case .espaço:
            cell.textFieldToDo.text = spaceList[indexPath.row]
        case .none:
            print("Erro!")
        }
        cell.selectionStyle = .none
        cell.checkButton.addTarget(self, action:#selector(CheckButtonClicked(sender:)) , for: .touchUpInside)
        cell.textFieldToDo.delegate = self
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let  cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ToDoTableViewCell
        tableView.deselectRow(at: indexPath, animated: true)
        cell.textFieldToDo.isEnabled = true
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height:100))
        
        
        let label = UILabel(frame: CGRect(x: 5 , y: 5, width: 100, height: 15))
        label.tag = section
        headerView.addSubview(label)
        
        
        let button = UIButton(frame: CGRect(x: 360, y: 10, width: 10, height: 11))
        button.tag = section
        button.setImage(UIImage(named: "remove_button"), for: UIControl.State.normal)
        button.backgroundColor = .blue
        headerView.addSubview(button)
        
        switch section {
        case 0:
            button.addTarget(self,action:#selector(comidaBut),for:.touchUpInside)
            label.text = "Comidas"
            return headerView
        case 1:
            button.addTarget(self,action:#selector(bebidasBut),for:.touchUpInside)
            label.text = "Bebidas"
            return headerView
        case 2:
            button.addTarget(self,action:#selector(utensiliosBut),for:.touchUpInside)
            label.text = "Utensilios"
            return headerView
        case 3:
            button.addTarget(self,action:#selector(descartaveisBut),for:.touchUpInside)
            label.text = "Descartaveis"
            return headerView
        case 4:
            button.addTarget(self,action:#selector(espacosBut),for:.touchUpInside)
            label.text = "Espaços"
            return headerView
        default:
            return headerView
        }
        
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard let sectionType = Section.init(rawValue: indexPath.section) else { return }
        if editingStyle == .delete {
            tableView.beginUpdates()
            switch sectionType {
            case .comida:
                foodList.remove(at: indexPath.row)
            case .bebidas:
                drinksList.remove(at: indexPath.row)
            case .utensílios:
                utensilsList.remove(at: indexPath.row)
            case .descartáveis:
                disposableList.remove(at: indexPath.row)
            case .espaço:
                spaceList.remove(at: indexPath.row)
            case .none:
                print("Erro!")
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
    
    @objc func CheckButtonClicked(sender:UIButton){
        if sender.isSelected{
            sender.isSelected = false
        }
        else{
            sender.isSelected = true
        }
        
    }
    @objc func comidaBut(sender:UIButton) {
        sectionInEdit = .comida
        let array = foodList
        let indexPath = IndexPath.init(row:array[sectionInEdit.rawValue].count - 1, section: Section.comida.rawValue)
        tableViewToDoList.beginUpdates()
//        let cell = tableViewToDoList.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ToDoTableViewCell
        tableViewToDoList.insertRows(at: [indexPath], with: .none)
        tableViewToDoList.endUpdates()
//        print("comidaButClicked")
//        cell.itensTF.tag = sectionNumber
//        cell.tag = cellTag
    }
    
    
    @objc func bebidasBut(sender:UIButton) {
        sectionInEdit = .bebidas
        let array = drinksList
        let indexPath = IndexPath.init(row:array[sectionInEdit.rawValue].count - 1, section: Section.comida.rawValue)
        tableViewToDoList.beginUpdates()
//        let cell = tableViewToDoList.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ToDoTableViewCell
        tableViewToDoList.insertRows(at: [indexPath], with: .none)
        tableViewToDoList.endUpdates()
//        print("comidaButClicked")
//        cell.itensTF.tag = sectionNumber
//        cell.tag = cellTag
    }
    
    @objc func utensiliosBut(sender:UIButton) {
        sectionInEdit = .utensílios
        let array = utensilsList
        let indexPath = IndexPath.init(row:array[sectionInEdit.rawValue].count - 1, section: Section.comida.rawValue)
        tableViewToDoList.beginUpdates()
//        let cell = tableViewToDoList.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ToDoTableViewCell
        tableViewToDoList.insertRows(at: [indexPath], with: .none)
        tableViewToDoList.endUpdates()
//        print("comidaButClicked")
//        cell.itensTF.tag = sectionNumber
//        cell.tag = cellTag
    }
    
    @objc func descartaveisBut(sender:UIButton) {
        sectionInEdit = .descartáveis
        let array = disposableList
        let indexPath = IndexPath.init(row:array[sectionInEdit.rawValue].count - 1, section: Section.comida.rawValue)
        tableViewToDoList.beginUpdates()
//        let cell = tableViewToDoList.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ToDoTableViewCell
        tableViewToDoList.insertRows(at: [indexPath], with: .none)
        tableViewToDoList.endUpdates()
//        print("comidaButClicked")
//        cell.itensTF.tag = sectionNumber
//        cell.tag = cellTag
    }
    
    @objc func espacosBut(sender:UIButton) {
        sectionInEdit = .espaço
        let array = spaceList
        let indexPath = IndexPath.init(row:array[sectionInEdit.rawValue].count - 1, section: Section.comida.rawValue)
        tableViewToDoList.beginUpdates()
//        let cell = tableViewToDoList.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ToDoTableViewCell
        tableViewToDoList.insertRows(at: [indexPath], with: .none)
        tableViewToDoList.endUpdates()
//        print("comidaButClicked")
//        cell.itensTF.tag = sectionNumber
//        cell.tag = cellTag
    }
    
}

//MARK: - TextField Controller

extension ToDoListViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let taskToSave = textField.text else { return }
        switch sectionInEdit {
        case .comida:
            foodList.append(taskToSave)
            print(foodList)
        case .bebidas:
            drinksList.append(taskToSave)
        case .utensílios:
            utensilsList.append(taskToSave)
        case .descartáveis:
            disposableList.append(taskToSave)
        case .espaço:
            spaceList.append(taskToSave)
        case .none:
            print("Erro!")
        }
        tableViewToDoList.reloadData()
    }
    
    
}
