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
    var a = 0
    var cont  = 0
    var aux = 0
    var sectionNumber = 0
    var cellTag = 0
    var foodList:[NSManagedObject] = []
    var drinksList:[NSManagedObject] = []
    var disposableList:[NSManagedObject] = []
    var spaceList:[NSManagedObject] = []
    var utensilsList:[NSManagedObject] = []
    
    var contador1 = -1
    var contador2 = -1
    var contador3 = -1
    var contador4 = -1
    var contador5 = -1
    var posi1 = 5
    var posi2 = 2
    var posi3 = 3
    var posi4 = 4
    var posi5 = 6
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Oque Fazer"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.deleteAllData(entity: "Food")
    }
    
    //Aqui tem comentário
    var churrascoToDo = [["Decidir que Carnes usar","Mensurar quantidade de carnes","Comprar carnes","Decidir que tempero de carne usar","Comprar temperos","Comprar carvão"],["Decidir que bebidas comprar","Comprar bebidas","Comprar gelo"],["Comprar copos","Comprar pratos","Comprar espetinhos","Comprar talheres"],["Verificar se há amoladores","Verificar talheres","Verificar pegadores","Veridicar facas","Verificar tábuas"],["Verificar cadeiras","Alugar cadeiras","Verificar mesas","Alugar mesas","Verificar Local","Alugar local","Preparar local"]]
    var ReuniaoDeAmigos = [["Decida como vai ser o bolo","Encomende o bolo com antecedencia","Decida os salgadinhos","Compre os salgadinhos","Decida os docinhos","Compre os docinhos","Monte um cardápio","Compre ingredientes para os pratos(caso não haja buffet)","Decida se vai contratar um buffet","Decida se vai contratar um buffet"],["Defina todas as bebidas","Compre todas as bebidas","Certifique-se de gelar as bebidas no dia anterior"],["Escolha o tema da festa","Defina o preço total da festa","Confirme todos os serviços contratados","Faça uma lista dos profissionais envolvidos","Defina as musicas","Decida os adereços utilizados","Compre os adereços","Compre balões"],["Compre as velas","Compre ou alugue toalhas","adquira pratos","Compre guardanapos","Compre bandejas para doces e salgados","Decida sobre as atividades de festa","adquira copos","adquira talheres","Compre fita dupla face","Compre fósforos","Compre barbante"],["Cheque a estrutura do local","Cheque a disponibilidade das mesas e cadeiras","Garanta a limpeza do local","Prepare os banheiros para os convidados","Defina como organizar o ambiente  de acordo com o tema"]]
    var Aniversario =  [["Defina se cada um trará um prato","Defina se cada um trará uma sobremesa","Defina que prato você fará","Defina os aperitivos e petiscos","Compre os ingredientes para seu prato","Compre o(s) ingredientes para as sobremesa(s)","Compre os ingredientes para preparar os petiscos"],["Defina os tipos de  bebida","Defina se cada um  trará uma bebida","Compre as bebidas","Coloque as bebidas para gelar no dia anterior","Organize as bebidas em um local de facil acesso"],["Defina as músicas","Cheque as restrições alimentícias de seus amigos","Cheque a afinidade entre seus convidados","Compre palitos de dente, guardanapos e outros utilitários","Compre os adereços","Defina o tema da festa"],["Separe pratos","Separe copos","Separe os talheres","Lave todas as louças que serão utilizadas"],["Limpe o local","Limpe o(s) banheiro(s)","Prepare os banheiros para os convidados","Garanta o conforto do local","Defina como organizar o ambiente  de acordo com o tema"]]
    
    //MARK: - Core Data Functions
    
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
            switch section {
            case 0:
                foodList.append(toDoTask)
            case 1:
                drinksList.append(toDoTask)
            case 2:
                utensilsList.append(toDoTask)
            case 3:
                disposableList.append(toDoTask)
            case 4:
                spaceList.append(toDoTask)
            default:
                print("Erro!")
            }
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
            foodList[index] = usrObj[index]
            
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

extension ListaDoQueFazerViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return churrascoToDo[section].count
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ToDoTableViewCell
        cell.textFieldToDo.text = churrascoToDo[indexPath.section][indexPath.row]
        cell.textFieldToDo.delegate = self
        if cell.textFieldToDo.text != "" {
            cell.textFieldToDo.isEnabled = false
        }
        return cell
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
        
        if editingStyle == .delete{
            if indexPath.section == 0{
                tableView.beginUpdates()
                if indexPath.row > posi1 {
                    self.delete(entity: "Food", toDoTask: churrascoToDo[0][indexPath.row])
                }
                posi1 -= 1
                churrascoToDo[0].remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                tableView.endUpdates()
                
            }
            if indexPath.section == 1{
                tableView.beginUpdates()
                if indexPath.row > posi2 {
                    self.delete(entity: "Drinks", toDoTask: churrascoToDo[1][indexPath.row])
                }
                posi2 -= 1
                churrascoToDo[1].remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                tableView.endUpdates()
                
            }
            if indexPath.section == 2{
                tableView.beginUpdates()
                if indexPath.row > posi1 {
                    self.delete(entity: "Utensils", toDoTask: churrascoToDo[2][indexPath.row])
                }
                posi3 -= 1
                churrascoToDo[2].remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                tableView.endUpdates()
                
            }
            if indexPath.section == 3{
                tableView.beginUpdates()
                if indexPath.row > posi1 {
                    self.delete(entity: "Disposable", toDoTask: churrascoToDo[3][indexPath.row])
                }
                posi4 -= 1
                churrascoToDo[3].remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                tableView.endUpdates()
                
            }
            if indexPath.section == 4{
                tableView.beginUpdates()
                if indexPath.row > posi1 {
                    self.delete(entity: "Space", toDoTask: churrascoToDo[4][indexPath.row])
                }
                posi5 -= 1
                churrascoToDo[4].remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                tableView.endUpdates()
                
            }
            
            
            
            
            
            
        }
    }
    
    @objc func comidaBut(sender:UIButton) {
        sectionNumber = 0
        churrascoToDo[0].append("")
        let indexPath = IndexPath.init(row:churrascoToDo[0].count-1, section: 0)
        tableViewToDoList.beginUpdates()
        let cell = tableViewToDoList.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ToDoTableViewCell
        tableViewToDoList.insertRows(at: [indexPath], with: .none)
        tableViewToDoList.endUpdates()
        print("comidaButClicked")
        cell.itensTF.tag = sectionNumber
        cell.tag = cellTag
    }
    
    
    @objc func bebidasBut(sender:UIButton) {
        sectionNumber = 1
        churrascoToDo[1].append("")
        let indexPath = IndexPath.init(row:churrascoToDo[1].count-1, section: 1)
        tableViewToDoList.beginUpdates()
        let cell = tableViewToDoList.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ToDoTableViewCell
        cell.itensTF.text = ""
        tableViewToDoList.insertRows(at: [indexPath], with: .none)
        tableViewToDoList.endUpdates()
        print("bebidasButClicked")
        cell.itensTF.tag = sectionNumber
        cellTagged()
        cell.tag = cellTag
    }
    
    @objc func utensiliosBut(sender:UIButton) {
        sectionNumber = 2
        churrascoToDo[2].append("")
        let indexPath = IndexPath.init(row:churrascoToDo[2].count-1, section: 2)
        tableViewToDoList.beginUpdates()
        let cell = tableViewToDoList.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ToDoTableViewCell
        cell.itensTF.text = ""
        tableViewToDoList.insertRows(at: [indexPath], with: .none)
        tableViewToDoList.endUpdates()
        print("utensiliosButClicked")
        cell.itensTF.tag = sectionNumber
        cellTagged()
        cell.tag = cellTag
    }
    
    @objc func descartaveisBut(sender:UIButton) {
        sectionNumber = 3
        churrascoToDo[3].append("")
        let indexPath = IndexPath.init(row:churrascoToDo[3].count-1, section: 3)
        tableViewToDoList.beginUpdates()
        let cell = tableViewToDoList.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ToDoTableViewCell
        cell.itensTF.text = ""
        tableViewToDoList.insertRows(at: [indexPath], with: .none)
        tableViewToDoList.endUpdates()
        print("descartaveisButClicked")
        cell.itensTF.tag = sectionNumber
        cellTagged()
        cell.tag = cellTag
    }
    
    @objc func espacosBut(sender:UIButton) {
        sectionNumber = 4
        churrascoToDo[4].append("")
        let indexPath = IndexPath.init(row:churrascoToDo[4].count-1, section: 4)
        tableViewToDoList.beginUpdates()
        let cell = tableViewToDoList.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ToDoTableViewCell
        cell.itensTF.text = ""
        tableViewToDoList.insertRows(at: [indexPath], with: .none)
        tableViewToDoList.endUpdates()
        print("espaçosButClicked")
        cell.itensTF.tag = sectionNumber
        cellTagged()
        cell.tag = cellTag
        a = cell.tag
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //print(sectionNumber)
        print(a)
    }
    func cellTagged(){
        cellTag = cellTag + 1
        
        
    }
    
}

//MARK: - TextField Controller

//rtfgcjygvhbjn

extension ListaDoQueFazerViewController: UITextFieldDelegate {
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        var entidadeNome = String()
        guard let taskToSave = textField.text else { return false }
        switch sectionNumber {
        case 0:
            posi1 += 1
            contador1 += 1
            entidadeNome = "Food"
            self.save(task: taskToSave, entityName: entidadeNome, section: sectionNumber)
            churrascoToDo[sectionNumber][posi1] = foodList[contador1].value(forKeyPath: "toDo") as? String ?? ""
            print(foodList)
        case 1:
            posi2 += 1
            contador2 += 1
            entidadeNome = "Drinks"
            self.save(task: taskToSave, entityName: entidadeNome, section: sectionNumber)
            churrascoToDo[sectionNumber][posi2] = drinksList[contador2].value(forKeyPath: "toDo") as? String ?? ""
            print(drinksList)
        case 2:
            posi3 += 1
            contador3 += 1
            entidadeNome = "Utensils"
            self.save(task: taskToSave, entityName: entidadeNome, section: sectionNumber)
            print(churrascoToDo[sectionNumber])
            churrascoToDo[sectionNumber][posi3] = utensilsList[contador3].value(forKeyPath: "toDo") as? String ?? ""
            print(utensilsList)
        case 3:
            posi4 += 1
            contador4 += 1
            entidadeNome = "Disposable"
            print(churrascoToDo[sectionNumber])
            self.save(task: taskToSave, entityName: entidadeNome, section: sectionNumber)
            churrascoToDo[sectionNumber][posi4] = disposableList[contador4].value(forKeyPath: "toDo") as? String ?? ""
            print(disposableList)
        case 4:
            posi5 += 1
            contador5 += 1
            entidadeNome = "Space"
            self.save(task: taskToSave, entityName: entidadeNome, section: sectionNumber)
            churrascoToDo[sectionNumber][posi5] = spaceList[contador5].value(forKeyPath: "toDo") as? String ?? ""
            print(spaceList)
        default:
            print("Erro!")
        }
                
        //self.save(task: taskToSave, entityName: entidadeNome)
        //churrascoToDo[sectionNumber][posi] = foodList[contador].value(forKeyPath: "toDo") as? String ?? ""
        //print(foodList)
       
        tableViewToDoList.reloadData()
        return  self.view.endEditing(true)
    }
    // Salvar = OK
    // Acrescentar na Cell = OK
    // Apagar Cell = OK
    // Acrescentar em todas as sections = OK
    // Apagar em todas as sections = OK
    
}
