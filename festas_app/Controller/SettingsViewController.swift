//
//  ViewControllerConfigGeral.swift
//  festas_app
//
//  Created by Rafael Dias Gonçalves on 01/10/20.
//  Copyright © 2020 Rafael Dias Gonçalves. All rights reserved.
//

import UIKit
import CoreData

class SettingsViewController: UIViewController {

    @IBOutlet weak var ButtonExcluir: UIButton!
    @IBOutlet weak var ButtonFinalizar: UIButton!
    @IBOutlet weak var viewDetalhesConvidados: UIView!
    @IBOutlet weak var ViewDetalhesData: UIView!
    @IBOutlet weak var viewDetalhes: UIView!
    @IBOutlet weak var viewDetalhesTarefas: UIView!
    @IBOutlet weak var typeNameTextField: UITextField!
    @IBOutlet weak var localNameTextField: UITextField!
    @IBOutlet weak var dayEventLabel: UILabel!
    @IBOutlet weak var monthEventLabel: UILabel!
    @IBOutlet weak var timeEventTextView: UITextView!
    @IBOutlet weak var dateTextView: UITextView!
    
    let calendar = Calendar.current
    let rightNow = Date()
    var localName = String()
    var typeName = String()
    var dayEvent = String()
    var monthEvent = String()
    var hourEvent = String()
    var minuteEvent = String()
    
    let datePicker = UIDatePicker()
    let timePIcker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ViewDetalhesData.layer.cornerRadius = 12
        self.viewDetalhes.layer.cornerRadius = 12
        self.viewDetalhesTarefas.layer.cornerRadius = 12
        self.viewDetalhesConvidados.layer.cornerRadius = 12
        self.ButtonExcluir.layer.cornerRadius = 12
        self.ButtonFinalizar.layer.cornerRadius = 12
        createDatePickerView()
        createTimePickerView()
        typeNameTextField.isEnabled = false
        localNameTextField.isEnabled = false
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
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
        do {
            let results = try managedContext.fetch(fetchRequest)
            for i in 0...results.count - 1 {
                if results[i].value(forKey: "type") != nil {
                    typeName = results[i].value(forKey: "type") as! String
                }
                
                if results[i].value(forKey: "local") != nil {
                    localName = results[i].value(forKey: "local") as! String
                }
                if results[i].value(forKey: "day") != nil {
                    dayEvent = results[i].value(forKey: "day") as! String
                }
                if results[i].value(forKey: "month") != nil {
                    monthEvent = results[i].value(forKey: "month") as! String
                }
                if results[i].value(forKey: "hour") != nil {
                    hourEvent = results[i].value(forKey: "hour") as! String
                }
                if results[i].value(forKey: "minute") != nil {
                    minuteEvent = results[i].value(forKey: "minute") as! String
                }
            }
            localNameTextField.text = localName
            typeNameTextField.text = typeName
            dayEventLabel.text = dayEvent
            let timeEvent = hourEvent + ":" + minuteEvent
            timeEventTextView.text = timeEvent
            switch monthEvent {
            case "01":
                monthEventLabel.text = "JAN"
            case "02":
                monthEventLabel.text = "FEV"
            case "03":
                monthEventLabel.text = "MAR"
            case "04":
                monthEventLabel.text = "ABR"
            case "05":
                monthEventLabel.text = "MAI"
            case "06":
                monthEventLabel.text = "JUN"
            case "07":
                monthEventLabel.text = "JUL"
            case "08":
                monthEventLabel.text = "AGO"
            case "09":
                monthEventLabel.text = "SET"
            case "10":
                monthEventLabel.text = "OUT"
            case "11":
                monthEventLabel.text = "NOV"
            case "12":
                monthEventLabel.text = "DEZ"
            default:
                print("Erro!!")
            }
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func save(newName: String) {
        
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
        modelType.setValue(newName, forKeyPath: "type")
        
        // 4
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func saveLocal(local: String) {
        
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
        
        let place = NSManagedObject(entity: entity,
                                    insertInto: managedContext)
        
        // 3
        place.setValue(local, forKeyPath: "local")
        
        // 4
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func saveDay(dayToEvent: String) {
        
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
        
        let day = NSManagedObject(entity: entity,
                                    insertInto: managedContext)
        
        // 3
        day.setValue(dayToEvent, forKeyPath: "day")
        
        // 4
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }

    func saveMonth(monthToEvent: String) {
        
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
        
        let month = NSManagedObject(entity: entity,
                                    insertInto: managedContext)
        
        // 3
        month.setValue(monthToEvent, forKeyPath: "month")
        
        // 4
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func saveHour(hourToEvent: String) {
        
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
        
        let hour = NSManagedObject(entity: entity,
                                    insertInto: managedContext)
        
        // 3
        hour.setValue(hourToEvent, forKeyPath: "hour")
        
        // 4
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func saveMinute(minuteToEvent: String) {
        
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
        
        let minute = NSManagedObject(entity: entity,
                                    insertInto: managedContext)
        
        // 3
        minute.setValue(minuteToEvent, forKeyPath: "minute")
        
        // 4
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func createDatePickerView(){
        // Create toolBar
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        //Create bar Button
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action:#selector(donePressed))
        
        //assign done button to toolbar
        toolBar.setItems([doneBtn], animated: true)
        //assign toolbar to textfield
        dateTextView.inputAccessoryView = toolBar
        //assign datePicker to textField
        dateTextView.inputView = datePicker
        datePicker.datePickerMode  = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.locale = Locale(identifier: "pt_BR")
    }
    @objc func donePressed(){
        let formatacao = DateFormatter()
        formatacao.dateStyle = .long
        formatacao.timeStyle = .none
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM"
        let month: String = dateFormatter.string(from: self.datePicker.date)
        dateFormatter.dateFormat = "dd"
        let day: String = dateFormatter.string(from: self.datePicker.date)
        dayEventLabel.text = day
        switch month {
        case "01":
            monthEventLabel.text = "JAN"
        case "02":
            monthEventLabel.text = "FEV"
        case "03":
            monthEventLabel.text = "MAR"
        case "04":
            monthEventLabel.text = "ABR"
        case "05":
            monthEventLabel.text = "MAI"
        case "06":
            monthEventLabel.text = "JUN"
        case "07":
            monthEventLabel.text = "JUL"
        case "08":
            monthEventLabel.text = "AGO"
        case "09":
            monthEventLabel.text = "SET"
        case "10":
            monthEventLabel.text = "OUT"
        case "11":
            monthEventLabel.text = "NOV"
        case "12":
            monthEventLabel.text = "DEZ"
        default:
            print("Erro!!")
        }
        self.view.endEditing(true)
        
    }
    func createTimePickerView(){
        let toolbar1 = UIToolbar()
        toolbar1.sizeToFit()
        let doneBtn1 = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed1))
        toolbar1.setItems([doneBtn1], animated: true)
        timeEventTextView.inputAccessoryView = toolbar1
        timeEventTextView.inputView = timePIcker
        timePIcker.datePickerMode = .time
        timePIcker.preferredDatePickerStyle = .wheels
        timePIcker.locale = Locale(identifier: "pt_BR")
    }

    @objc func donePressed1(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "mm"
        let minutes: String = dateFormatter.string(from: self.timePIcker.date)
        dateFormatter.dateFormat = "HH"
        let hour: String = dateFormatter.string(from: self.timePIcker.date)
        timeEventTextView.text = hour + ":" + minutes
        self.view.endEditing(true)
    }
    
    @IBAction func editDetailsButton(_ sender: UIButton) {
        if sender.tag == 1 {
            sender.tag = 2
            typeNameTextField.isEnabled = true
            localNameTextField.isEnabled = true
            dateTextView.isUserInteractionEnabled = true
        } else {
            sender.tag = 1
            let dateFormatter = DateFormatter()
            timeEventTextView.isEditable = false
            dateFormatter.dateFormat = "mm"
            let minutes: String = dateFormatter.string(from: self.timePIcker.date)
            dateFormatter.dateFormat = "HH"
            let hour: String = dateFormatter.string(from: self.timePIcker.date)
            dateTextView.isUserInteractionEnabled = false
            dateFormatter.dateFormat = "MM"
            let month: String = dateFormatter.string(from: self.datePicker.date)
            dateFormatter.dateFormat = "dd"
            let day: String = dateFormatter.string(from: self.datePicker.date)
            typeNameTextField.isEnabled = false
            self.save(newName: typeNameTextField.text ?? "")
            localNameTextField.isEnabled = false
            self.saveLocal(local: localNameTextField.text ?? "")
            self.saveHour(hourToEvent: hour)
            self.saveMinute(minuteToEvent: minutes)
            self.saveDay(dayToEvent: day)
            self.saveMonth(monthToEvent: month)
        }
        
    }
    
    //Por para salvar td ao final da edição
    //Talvez trocar pela função de edição

}
