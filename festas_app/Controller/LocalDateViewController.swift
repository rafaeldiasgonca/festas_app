//
//  ViewControllerConfiguracao.swift
//  festas_app
//
//  Created by Rafael Dias Gonçalves on 22/09/20.
//  Copyright © 2020 Rafael Dias Gonçalves. All rights reserved.
//

import UIKit
import CoreData


class LocalDateViewController: UIViewController  {
   
    @IBOutlet weak var dateTextView: UITextView!
    @IBOutlet weak var timeTextView: UITextView!
    @IBOutlet weak var localTextField: UITextField!
    var localization:NSManagedObject?
    var dayEvent:NSManagedObject?
    var monthEvent:NSManagedObject?
    var hourEvent:NSManagedObject?
    var minuteEvent:NSManagedObject?
    var yearEvent:NSManagedObject?
    @IBOutlet weak var EditButdate: UIButton!
    @IBOutlet weak var EdiButHour: UIButton!
    @IBOutlet weak var dateView: UIView!
    
    
    let datePicker = UIDatePicker()
    let timePicker = UIDatePicker()
    var tituloRecebido = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = tituloRecebido
        localTextField.delegate = self
        let gestureOneTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(endEditing(_:)))
        gestureOneTapRecognizer.numberOfTapsRequired = 1
        gestureOneTapRecognizer.numberOfTouchesRequired = 1
        self.view.addGestureRecognizer(gestureOneTapRecognizer)
        timeTextView.isUserInteractionEnabled = false
        dateTextView.isUserInteractionEnabled = false
        
      
    
        
    }
    
    @objc func endEditing(_ gesture: UITapGestureRecognizer) {
        self.view.endEditing(true)
       
    }

    @IBAction func EditButDate(_ sender: Any) {
        dateTextView.isEditable = true
        createDatePickerView()
        self.dateTextView.becomeFirstResponder()
        
    }
    
    @IBAction func EditHourBut(_ sender: Any) {
        createTimePickerView()
        self.timeTextView.becomeFirstResponder()
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
            localization = place
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
            dayEvent = day
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
            monthEvent = month
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
            hourEvent = hour
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
            minuteEvent = minute
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
        dateFormatter.dateFormat = "yyyy"
        let year: String = dateFormatter.string(from: self.datePicker.date)
        dateFormatter.dateFormat = "MM"
        let month: String = dateFormatter.string(from: self.datePicker.date)
        dateFormatter.dateFormat = "dd"
        let day: String = dateFormatter.string(from: self.datePicker.date)
        self.saveDay(dayToEvent: day)
        self.saveMonth(monthToEvent: month)
        self.saveYear(yearToEvent: year)
        dateTextView.text = formatacao.string(from: datePicker.date)
        self.view.endEditing(true)
        
    }
    
    func createTimePickerView(){
        let toolbar1 = UIToolbar()
        toolbar1.sizeToFit()
        let doneBtn1 = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed1))
        toolbar1.setItems([doneBtn1], animated: true)
        timeTextView.inputAccessoryView = toolbar1
        timeTextView.inputView = timePicker
        timePicker.locale = NSLocale(localeIdentifier: "en_GB") as Locale
        timePicker.datePickerMode = .time
        timePicker.preferredDatePickerStyle = .wheels
        
    }
    
    @objc func donePressed1(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "mm"
        let minutes: String = dateFormatter.string(from: self.timePicker.date)
        dateFormatter.dateFormat = "HH"
        let hour: String = dateFormatter.string(from: self.timePicker.date)
        self.saveHour(hourToEvent: hour)
        self.saveMinute(minuteToEvent: minutes)
        let formatacao1 = DateFormatter()
        formatacao1.dateFormat = "HH:mm"
        timeTextView.text = formatacao1.string(from: timePicker.date)
        self.view.endEditing(true)
    }
    

}

extension LocalDateViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        //localTextField.borderStyle = .none
        self.saveLocal(local: localTextField.text ?? "")
        self.view.endEditing(true)

    }

}
