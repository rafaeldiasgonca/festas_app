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
    @IBOutlet weak var timeEventTextField: UITextField!
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
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "BalooBhai2-ExtraBold", size: 34) as Any]
        
        let gestureType = UITapGestureRecognizer(target: self, action: #selector(startEditingTypeName(_:)))
        gestureType.numberOfTapsRequired = 1
        gestureType.numberOfTouchesRequired = 1
        typeNameTextField.addGestureRecognizer(gestureType)
        
        let gestureLocal = UITapGestureRecognizer(target: self, action: #selector(startEditingLocal(_:)))
        gestureLocal.numberOfTapsRequired = 1
        gestureLocal.numberOfTouchesRequired = 1
        localNameTextField.addGestureRecognizer(gestureLocal)
        
        let gestureOneTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(endEditing(_:)))
        gestureOneTapRecognizer.numberOfTapsRequired = 1
        gestureOneTapRecognizer.numberOfTouchesRequired = 1
        self.view.addGestureRecognizer(gestureOneTapRecognizer)
       
        super.viewDidLoad()
        typeNameTextField.isUserInteractionEnabled = true
        typeNameTextField.becomeFirstResponder()
        typeNameTextField.backgroundColor = #colorLiteral(red: 0.5132836699, green: 0.4757140875, blue: 1, alpha: 1)
        localNameTextField.isUserInteractionEnabled = true
        localNameTextField.backgroundColor = #colorLiteral(red: 0.5132836699, green: 0.4757140875, blue: 1, alpha: 1)
        self.ViewDetalhesData.layer.cornerRadius = 12
        self.viewDetalhes.layer.cornerRadius = 12
        self.viewDetalhesTarefas.layer.cornerRadius = 12
        self.viewDetalhesConvidados.layer.cornerRadius = 12
        createDatePickerView()
        createTimePickerView()
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        timeEventTextField.isUserInteractionEnabled = false
    }
    
    @objc func startEditingTypeName(_ gesture: UITapGestureRecognizer) {
        typeNameTextField.isUserInteractionEnabled = true
        typeNameTextField.becomeFirstResponder()
        typeNameTextField.backgroundColor = #colorLiteral(red: 0.5132836699, green: 0.4757140875, blue: 1, alpha: 1)
    }
    
    @objc func startEditingLocal(_ gesture: UITapGestureRecognizer) {
        localNameTextField.isUserInteractionEnabled = true
        localNameTextField.becomeFirstResponder()
        localNameTextField.backgroundColor = #colorLiteral(red: 0.5132836699, green: 0.4757140875, blue: 1, alpha: 1)
    }
    
    @objc func endEditing(_ gesture: UITapGestureRecognizer) {
        self.view.endEditing(true)
        typeNameTextField.backgroundColor = #colorLiteral(red: 0.2940218747, green: 0.2438195944, blue: 0.8556853533, alpha: 1)
        localNameTextField.backgroundColor = #colorLiteral(red: 0.2940218747, green: 0.2438195944, blue: 0.8556853533, alpha: 1)
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
                timeEventTextField.text =  "Undefined Schedule"
            } else {
                let timeEvent = hourEvent + ":" + minuteEvent
                timeEventTextField.text = timeEvent
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
    
    @IBAction func EndBut(_ sender: Any) {
        let alert = UIAlertController(title: "", message: "Have in mind that you will lose all of your progress if you continue?", preferredStyle: UIAlertController.Style.alert)
             // add the actions (buttons)
        alert.addAction(UIAlertAction(title: "Continue", style: UIAlertAction.Style.default, handler: { [self]action in goAhead()}))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
             // show the alert
             self.present(alert, animated: true, completion: nil)

    }
    func goAhead(){
        let vc = self.storyboard?.instantiateViewController(identifier:"StartViewController")
              self.show(vc!, sender: self)
              self.deleteAllData(entity: "Guest")
              self.deleteAllData(entity: "Completed")
              self.deleteAllData(entity: "Disposable")
              self.deleteAllData(entity: "Drinks")
              self.deleteAllData(entity: "Food")
              self.deleteAllData(entity: "General")
              self.deleteAllData(entity: "Space")
              self.deleteAllData(entity: "Utensils")
        
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
        

        minute.setValue(minuteToEvent, forKeyPath: "minute")
        
        // 4
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
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


    
    func createDatePickerView(){
        // Create toolBar
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        //Create bar Button
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action:#selector(donePressed))
        
        //assign done button to toolbar
        toolBar.setItems([doneBtn], animated: true)
        //assign toolbar to textfield
//        dateTextView.inputAccessoryView = toolBar
        //assign datePicker to textField
     //   dateTextView.inputView = datePicker
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
//        timeEventTextView.inputAccessoryView = toolbar1
//        timeEventTextView.inputView = timePIcker
//        timePIcker.datePickerMode = .time
//        timePIcker.preferredDatePickerStyle = .wheels
//        timePIcker.locale = NSLocale(localeIdentifier: "en_GB") as Locale
    }

    @objc func donePressed1(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "mm"
        let minutes: String = dateFormatter.string(from: self.timePIcker.date)
        dateFormatter.dateFormat = "HH"
        let hour: String = dateFormatter.string(from: self.timePIcker.date)
        timeEventTextField.text = hour + ":" + minutes
        self.view.endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == typeNameTextField {
            guard let nameToSave = textField.text else { return }
            self.save(newName: nameToSave)
        }
        if textField == localNameTextField {
            guard let localToSave = textField.text else { return }
            self.saveLocal(local: localToSave)
        }
        textField.backgroundColor = #colorLiteral(red: 0.2940218747, green: 0.2438195944, blue: 0.8556853533, alpha: 1)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
    }
    

}
