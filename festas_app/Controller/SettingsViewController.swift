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
    @IBOutlet weak var dateTextField: UITextField!
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
    var yearEvent:NSManagedObject?
    
    let datePicker = UIDatePicker()
    let timePicker = UIDatePicker()
    
    override func viewDidLoad() {
        view.endEditing(true)
        typeNameTextField.delegate = self
        localNameTextField.delegate = self
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "BalooBhai2-ExtraBold", size: 34) as Any]
        
        //Gesture Type
        let gestureType = UITapGestureRecognizer(target: self, action: #selector(startEditingTypeName(_:)))
        gestureType.numberOfTapsRequired = 1
        gestureType.numberOfTouchesRequired = 1
        typeNameTextField.addGestureRecognizer(gestureType)
        
        //Gesture Local
        let gestureLocal = UITapGestureRecognizer(target: self, action: #selector(startEditingLocal(_:)))
        gestureLocal.numberOfTapsRequired = 1
        gestureLocal.numberOfTouchesRequired = 1
        localNameTextField.addGestureRecognizer(gestureLocal)
        
        //Gesture Date
        let gestureDate = UITapGestureRecognizer(target: self, action: #selector(startEditingDate(_:)))
        gestureDate.numberOfTapsRequired = 1
        gestureDate.numberOfTouchesRequired = 1
        dateTextField.addGestureRecognizer(gestureDate)
        
        //Gesture Time
        let gestureTime = UITapGestureRecognizer(target: self, action: #selector(startEditingTime(_:)))
        gestureTime.numberOfTapsRequired = 1
        gestureTime.numberOfTouchesRequired = 1
        timeEventTextField.addGestureRecognizer(gestureTime)
        
        //End Editing
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
        timeEventTextField.backgroundColor = #colorLiteral(red: 0.5132836699, green: 0.4757140875, blue: 1, alpha: 1)
        self.ViewDetalhesData.layer.cornerRadius = 12
        self.viewDetalhes.layer.cornerRadius = 12
        self.viewDetalhesTarefas.layer.cornerRadius = 12
        self.viewDetalhesConvidados.layer.cornerRadius = 12
        
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        timeEventTextField.tintColor = .clear
        dateTextField.tintColor = .clear
    }
    
    @objc func startEditingTypeName(_ gesture: UITapGestureRecognizer) {
        self.endEditingTime()
        self.endEditingDate()
        typeNameTextField.isUserInteractionEnabled = true
        typeNameTextField.becomeFirstResponder()
        typeNameTextField.backgroundColor = #colorLiteral(red: 0.5132836699, green: 0.4757140875, blue: 1, alpha: 1)
    }
    
    @objc func startEditingLocal(_ gesture: UITapGestureRecognizer) {
        self.endEditingTime()
        self.endEditingDate()
        localNameTextField.isUserInteractionEnabled = true
        localNameTextField.becomeFirstResponder()
        localNameTextField.backgroundColor = #colorLiteral(red: 0.5132836699, green: 0.4757140875, blue: 1, alpha: 1)
    }
    
    @objc func startEditingDate(_ gesture: UITapGestureRecognizer) {
        createDatePickerView()
        timeEventTextField.becomeFirstResponder()

    }
    
    @objc func startEditingTime(_ gesture: UITapGestureRecognizer) {
        createTimePickerView()
        timeEventTextField.becomeFirstResponder()
        timeEventTextField.backgroundColor = #colorLiteral(red: 0.5132836699, green: 0.4757140875, blue: 1, alpha: 1)
    }
    
    @objc func endEditing(_ gesture: UITapGestureRecognizer) {
        self.endEditingDate()
        self.endEditingTime()
        self.view.endEditing(true)
        typeNameTextField.backgroundColor = #colorLiteral(red: 0.2940218747, green: 0.2438195944, blue: 0.8556853533, alpha: 1)
        localNameTextField.backgroundColor = #colorLiteral(red: 0.2940218747, green: 0.2438195944, blue: 0.8556853533, alpha: 1)
        timeEventTextField.backgroundColor = #colorLiteral(red: 0.2940218747, green: 0.2438195944, blue: 0.8556853533, alpha: 1)
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
                timeEventTextField.text =  "--:--"
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
    
    func saveYear(yearToEvent: String) {
        
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
        month.setValue(yearToEvent, forKeyPath: "year")
        
        // 4
        do {
            try managedContext.save()
            yearEvent = month
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
        datePicker.datePickerMode = .date
//        datePicker.tintColor = .white
        dateTextField.inputView = datePicker
        datePicker.preferredDatePickerStyle = .wheels
        
    }
    
    func createTimePickerView(){
        timePicker.datePickerMode = .time
        timeEventTextField.inputView = timePicker
        timePicker.locale = NSLocale(localeIdentifier: "en_GB") as Locale
        timePicker.preferredDatePickerStyle = .wheels
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let nameToSave = typeNameTextField.text else { return }
        self.save(newName: nameToSave)
        guard let localToSave = localNameTextField.text else { return }
        self.saveLocal(local: localToSave)
        self.endEditingTime()
        self.endEditingDate()
        self.view.endEditing(true)
        typeNameTextField.backgroundColor = #colorLiteral(red: 0.2940218747, green: 0.2438195944, blue: 0.8556853533, alpha: 1)
        localNameTextField.backgroundColor = #colorLiteral(red: 0.2940218747, green: 0.2438195944, blue: 0.8556853533, alpha: 1)
        timeEventTextField.backgroundColor = #colorLiteral(red: 0.2940218747, green: 0.2438195944, blue: 0.8556853533, alpha: 1)

        
    }
    
    func endEditingTime() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "mm"
        let minutes: String = dateFormatter.string(from: timePicker.date)
        dateFormatter.dateFormat = "HH"
        let hour: String = dateFormatter.string(from: timePicker.date)
        self.saveHour(hourToEvent: hour)
        self.saveMinute(minuteToEvent: minutes)
        let formatacao1 = DateFormatter()
        formatacao1.dateFormat = "HH:mm"
        timeEventTextField.text = formatacao1.string(from: timePicker.date)
        self.view.endEditing(true)
        timeEventTextField.backgroundColor = #colorLiteral(red: 0.2940218747, green: 0.2438195944, blue: 0.8556853533, alpha: 1)
    }
    
    func endEditingDate() {
        let formatacao = DateFormatter()
        let dateFormatter = DateFormatter()
        formatacao.dateStyle = .long
        formatacao.timeStyle = .none
        dateFormatter.dateFormat = "yyyy"
        let year: String = dateFormatter.string(from: datePicker.date)
        dateFormatter.dateFormat = "MM"
        let month: String = dateFormatter.string(from: datePicker.date)
        dateFormatter.dateFormat = "dd"
        let day: String = dateFormatter.string(from: datePicker.date)
        self.saveDay(dayToEvent: day)
        self.saveMonth(monthToEvent: month)
        self.saveYear(yearToEvent: year)
        dayEventLabel.text = dayEvent
        monthEvent = month
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
        //dateTextField.text = formatacao.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
    }
    
    
}
