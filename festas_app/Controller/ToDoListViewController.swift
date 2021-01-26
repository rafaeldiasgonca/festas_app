///
//  ListaDoQueFazerViewController.swift
//  festas_app
//
//  Created by Rafael Dias Gonçalves on 02/10/20.
//  Copyright © 2020 Rafael Dias Gonçalves. All rights reserved.
//

import UIKit
import CoreData

class ToDoListViewController: UIViewController, UITextViewDelegate {

    
    @IBOutlet weak var tableViewToDoList: UITableView!
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
    var foodRows = 0
    var drinkRows = 0
    var spaceRows = 0
    var utiRows = 0
    var desRows = 0
    var textsSelected:[String] = []
    
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
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "To do"
        let gestureOneTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(endEditing(_:)))
        gestureOneTapRecognizer.numberOfTapsRequired = 1
        gestureOneTapRecognizer.numberOfTouchesRequired = 1
        self.view.addGestureRecognizer(gestureOneTapRecognizer)
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 44))
        view.addSubview(navBar)
        
        // let navItem = UINavigationItem(title: "SomeTitle")
        let backButton = UIBarButtonItem()
        backButton.title = "Something Else"
        let button = UIBarButtonItem(title: "Your Event", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.goBack))
        self.navigationItem.backBarButtonItem = button
    }
    
    @objc func goBack(){
        dismiss(animated: true, completion: nil)
    }
    
    @objc func endEditing(_ gesture: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //self.loadModelType()
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
        foodRows = foodList.count
        drinkRows = drinksList.count
        spaceRows = spaceList.count
        utiRows = utensilsList.count
        desRows = disposableList.count
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.deleteAllData(entity: "Food")
        self.savePreToDoListFood(foodArray: foodList, entityName: "Food")
        self.deleteAllData(entity: "Drinks")
        self.savePreToDoListDrinks(drinkArray: drinksList, entityName: "Drinks")
        self.deleteAllData(entity: "Space")
        self.savePreToDoListSpace(spaceArray: spaceList, entityName: "Space")
        self.deleteAllData(entity: "Disposable")
        self.savePreToDoListDisponsable(disponsableArray: disposableList, entityName: "Disposable")
        self.deleteAllData(entity: "Utensils")
        self.savePreToDoListUtensils(utensilsArray: utensilsList, entityName: "Utensils")
    }
    
    
    
    
    
    
    
    
    
    
    //MARK: - Core Data Functions
    
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
        if (foodArray.count > 0) {
            for i in 0...foodArray.count - 1 {
                saveTask(task: foodArray[i], entityName: entityName)
            }
        }
    }
    
    func savePreToDoListDrinks(drinkArray: [String], entityName: String) {
        if (drinkArray.count>0) {
            for i in 0...drinkArray.count - 1 {
                saveTask(task: drinkArray[i], entityName: entityName)
            }
        }
    }
    
    func savePreToDoListUtensils(utensilsArray: [String], entityName: String) {
        if (utensilsArray.count > 0) {
            for i in 0...utensilsArray.count - 1 {
                saveTask(task: utensilsArray[i], entityName: entityName)
            }
        }
    }
    
    func savePreToDoListDisponsable(disponsableArray: [String], entityName: String) {
        if (disponsableArray.count > 0) {
            for i in 0...disponsableArray.count - 1 {
                saveTask(task: disponsableArray[i], entityName: entityName)
            }
        }
    }
    
    func savePreToDoListSpace(spaceArray: [String], entityName: String) {
        if (spaceArray.count > 0) {
            for i in 0...spaceArray.count - 1 {
                saveTask(task: spaceArray[i], entityName: entityName)
            }
        }
    }
    
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
            if(results.count > 0) {
                for i in 0...results.count - 1 {
                    let element = results[i].value(forKey: "toDo") as? String ?? ""
                    foodList.append(element)
                }
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
            if (results.count > 0) {
                for i in 0...results.count - 1 {
                    let element = results[i].value(forKey: "toDo") as? String ?? ""
                    drinksList.append(element)
                }
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
            if (results.count > 0) {
                for i in 0...results.count - 1 {
                    let element = results[i].value(forKey: "toDo") as? String ?? ""
                    disposableList.append(element)
                }
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
            if (results.count > 0) {
                for i in 0...results.count - 1 {
                    let element = results[i].value(forKey: "toDo") as? String ?? ""
                    utensilsList.append(element)
                }
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
            if (results.count > 0) {
                for i in 0...results.count - 1 {
                    let element = results[i].value(forKey: "toDo") as? String ?? ""
                    spaceList.append(element)
                }
            }
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
            return foodRows
        case .bebidas:
            return drinkRows
        case .utensílios:
            return utiRows
        case .descartáveis:
            return desRows
        case .espaço:
            return spaceRows
        case .none:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ToDoTableViewCell
        guard let sectionType = Section.init(rawValue: indexPath.section) else { return .init() }
        switch sectionType {
        case .comida:
            if foodList.count > indexPath.row {
                cell.textViewToDo.text = foodList[indexPath.row]
            } else {
                cell.textViewToDo.text = ""
            }
        case .bebidas:
            if drinksList.count > indexPath.row {
                cell.textViewToDo.text = drinksList[indexPath.row]
            } else {
                cell.textViewToDo.text = ""
            }
            
        case .utensílios:
            if utensilsList.count > indexPath.row {
                cell.textViewToDo.text = utensilsList[indexPath.row]
            } else {
                cell.textViewToDo.text = ""
            }
            
        case .descartáveis:
            if disposableList.count > indexPath.row {
                cell.textViewToDo.text = disposableList[indexPath.row]
            } else {
                cell.textViewToDo.text = ""
            }
            
        case .espaço:
            if spaceList.count > indexPath.row {
                cell.textViewToDo.text = spaceList[indexPath.row]
            } else {
                cell.textViewToDo.text = ""
            }
            
        case .none:
            print("Erro!")
        }
        cell.checkButton.isUserInteractionEnabled = true
        cell.textViewToDo.isUserInteractionEnabled = true
        cell.selectionStyle = .none
        cell.textViewToDo.delegate = self
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let  cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ToDoTableViewCell
        tableView.deselectRow(at: indexPath, animated: true)
        cell.textViewToDo.isUserInteractionEnabled = true
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height:100))
        
        
        let label = UILabel(frame: CGRect(x: 5 , y: 5, width: 250, height: 20))
        label.tag = section
        headerView.addSubview(label)
        label.font = UIFont(name: "Baloo Bhai 2", size: 28)
        
        
        let button = UIButton(frame: CGRect(x: 360, y: 10, width: 10, height: 11))
        button.tag = section
        button.setImage(UIImage(named: "remove_button"), for: .normal)
        button.backgroundColor = .blue
        headerView.addSubview(button)
        
        switch section {
        case 0:
            button.addTarget(self,action:#selector(comidaBut),for:.touchUpInside)
            label.text = "Food"
            return headerView
        case 1:
            button.addTarget(self,action:#selector(bebidasBut),for:.touchUpInside)
            label.text = "Drinks"
            return headerView
        case 2:
            button.addTarget(self,action:#selector(utensiliosBut),for:.touchUpInside)
            label.text = "Utensils"
            return headerView
        case 3:
            button.addTarget(self,action:#selector(descartaveisBut),for:.touchUpInside)
            label.text = "Disposable"
            return headerView
        case 4:
            button.addTarget(self,action:#selector(espacosBut),for:.touchUpInside)
            label.text = "Place"
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
                foodRows -= 1
            case .bebidas:
                drinksList.remove(at: indexPath.row)
                drinkRows -= 1
            case .utensílios:
                utensilsList.remove(at: indexPath.row)
                utiRows -= 1
            case .descartáveis:
                disposableList.remove(at: indexPath.row)
                desRows -= 1
            case .espaço:
                spaceList.remove(at: indexPath.row)
                spaceRows -= 1
            case .none:
                print("Erro!")
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
    
    
    
    @objc func comidaBut(sender:UIButton) {
        foodRows += 1
        sectionInEdit = .comida
        let indexPath = IndexPath.init(row:foodRows-1, section: Section.comida.rawValue)
        tableViewToDoList.beginUpdates()
        tableViewToDoList.insertRows(at: [indexPath], with: .none)
        tableViewToDoList.endUpdates()
    }
    
    
    @objc func bebidasBut(sender:UIButton) {
        drinkRows += 1
        sectionInEdit = .bebidas
        let indexPath = IndexPath.init(row:drinkRows - 1, section: Section.comida.rawValue)
        tableViewToDoList.beginUpdates()
        tableViewToDoList.insertRows(at: [indexPath], with: .none)
        tableViewToDoList.endUpdates()
    }
    
    @objc func utensiliosBut(sender:UIButton) {
        utiRows += 1
        sectionInEdit = .utensílios
        let indexPath = IndexPath.init(row:utiRows - 1, section: Section.comida.rawValue)
        tableViewToDoList.beginUpdates()
        tableViewToDoList.insertRows(at: [indexPath], with: .none)
        tableViewToDoList.endUpdates()
    }
    
    @objc func descartaveisBut(sender:UIButton) {
        desRows += 1
        sectionInEdit = .descartáveis
        let indexPath = IndexPath.init(row:desRows - 1, section: Section.comida.rawValue)
        tableViewToDoList.beginUpdates()
        tableViewToDoList.insertRows(at: [indexPath], with: .none)
        tableViewToDoList.endUpdates()
    }
    
    @objc func espacosBut(sender:UIButton) {
        spaceRows += 1
        sectionInEdit = .espaço
        let indexPath = IndexPath.init(row:spaceRows - 1, section: Section.comida.rawValue)
        tableViewToDoList.beginUpdates()
        tableViewToDoList.insertRows(at: [indexPath], with: .none)
        tableViewToDoList.endUpdates()
    }
    
}

//MARK: - TextField Controller

extension ToDoListViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let taskToSave = textField.text else { return }
        switch sectionInEdit {
        case .comida:
            if textField.text == "" {
                foodList.append(taskToSave)
            }
        case .bebidas:
            if textField.text == "" {
                drinksList.append(taskToSave)
            }
        case .utensílios:
            if textField.text == "" {
                utensilsList.append(taskToSave)
            }
        case .descartáveis:
            if textField.text == "" {
                disposableList.append(taskToSave)
            }
        case .espaço:
            if textField.text == "" {
                spaceList.append(taskToSave)
            }
        case .none:
            print("Erro!")
        }
        tableViewToDoList.reloadData()
    }
    
    
}
