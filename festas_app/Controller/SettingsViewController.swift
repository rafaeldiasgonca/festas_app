//
//  ViewControllerConfigGeral.swift
//  festas_app
//
//  Created by Rafael Dias Gonçalves on 01/10/20.
//  Copyright © 2020 Rafael Dias Gonçalves. All rights reserved.
//

import UIKit
import CoreData

class SettingsViewController: UIViewController, UITextFieldDelegate {

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
    @IBOutlet weak var numberOfGuestLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    var convidados = 0
    
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
        typeNameTextField.delegate = self
        localNameTextField.delegate = self
        
       //self.title = typeName
        super.viewDidLoad()
        self.ViewDetalhesData.layer.cornerRadius = 12
        self.viewDetalhes.layer.cornerRadius = 12
        self.viewDetalhesTarefas.layer.cornerRadius = 12
        self.viewDetalhesConvidados.layer.cornerRadius = 12
        createDatePickerView()
        createTimePickerView()
        typeNameTextField.isEnabled = false
        localNameTextField.isEnabled = false
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        updateNumberOfGuests()
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
            if localName == "" {
                localNameTextField.text = "No location set"
            }
            typeNameTextField.text = typeName
            if dayEvent != "" {
                dayEventLabel.text = dayEvent
            } else {
                dayEventLabel.text = "00"
            }
            if hourEvent == "" && minuteEvent == "" {
                timeEventTextView.text =  "Undefined Schedule"
            } else {
                let timeEvent = hourEvent + ":" + minuteEvent
                timeEventTextView.text = timeEvent
            }
            switch monthEvent {
            case "01":
                monthEventLabel.text = "JAN"
            case "02":
                monthEventLabel.text = "FEB"
            case "03":
                monthEventLabel.text = "MAR"
            case "04":
                monthEventLabel.text = "APR"
            case "05":
                monthEventLabel.text = "MAY"
            case "06":
                monthEventLabel.text = "JUN"
            case "07":
                monthEventLabel.text = "JUL"
            case "08":
                monthEventLabel.text = "AUG"
            case "09":
                monthEventLabel.text = "SEP"
            case "10":
                monthEventLabel.text = "OCT"
            case "11":
                monthEventLabel.text = "NOV"
            case "12":
                monthEventLabel.text = "DEC"
            default:
                monthEventLabel.text = "UND"
            }
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func updateNumberOfGuests() {
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
            let results = try managedContext.fetch(fetchRequest)
            convidados = results.count
            numberOfGuestLabel.text = "\(convidados)"
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
        timePIcker.locale = NSLocale(localeIdentifier: "en_GB") as Locale
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
//            typeNameTextField.backgroundColor =  colorLiteral(red: 0.5005502701, green: 0.4901447296, blue: 1, alpha: 1)
//            localNameTextField.backgroundColor =  colorLiteral(red: 0.5005502701, green: 0.4901447296, blue: 1, alpha: 1)
            localNameTextField.alpha = 1
            localNameTextField.isEnabled = true
            dateTextView.isUserInteractionEnabled = true
            if typeNameTextField.text == "Sem Nome Definido" {
                typeNameTextField.text = ""
            }
            if localNameTextField.text == "Sem Local Definido" {
                localNameTextField.text = ""
            }
            let image = UIImage(systemName: "checkmark.circle.fill")
            editButton.setImage(image, for: .normal)
        } else {
            sender.tag = 1
            let dateFormatter = DateFormatter()
            timeEventTextView.isEditable = false
            typeNameTextField.backgroundColor = UIColor(named: "card_color-1")
            localNameTextField.backgroundColor = UIColor(named: "card_color-1")
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
            if typeNameTextField.text == "" {
                typeNameTextField.text = "Sem Nome Definido"
            }
            self.save(newName: typeNameTextField.text ?? "")
            localNameTextField.isEnabled = false
            if localNameTextField.text == "" {
                localNameTextField.text = "Sem Local Definido"
            }
            self.saveLocal(local: localNameTextField.text ?? "")
            self.saveHour(hourToEvent: hour)
            self.saveMinute(minuteToEvent: minutes)
            self.saveDay(dayToEvent: day)
            self.saveMonth(monthToEvent: month)
            let image = UIImage(systemName: "pencil.circle.fill")
            editButton.setImage(image, for: .normal)
        }
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
    }
    
    //Por para salvar td ao final da edição
    //Talvez trocar pela função de edição

}
