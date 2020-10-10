//
//  ViewControllerConfiguracao.swift
//  festas_app
//
//  Created by Rafael Dias Gonçalves on 22/09/20.
//  Copyright © 2020 Rafael Dias Gonçalves. All rights reserved.
//

import UIKit
import CoreData


class SettingsViewController: UIViewController  {
    
    @IBOutlet weak var dateTextView: UITextView!
    @IBOutlet weak var timeTextView: UITextView!
    @IBOutlet weak var localTextField: UITextField!
    var localization:NSManagedObject?
    
    let datePicker = UIDatePicker()
    let timePIcker = UIDatePicker()
    
    var tituloRecebido = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = tituloRecebido
        localTextField.delegate = self
        createDatePickerView()
        createTimePickerView()
    }
    
    func save(local: String) {
        
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
    }
    @objc func donePressed(){
        let formatacao = DateFormatter()
        formatacao.dateStyle = .long
        formatacao.timeStyle = .none
        dateTextView.text = formatacao.string(from: datePicker.date)
        self.view.endEditing(true)
        
    }
    func createTimePickerView(){
        let toolbar1 = UIToolbar()
        toolbar1.sizeToFit()
        let doneBtn1 = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed1))
        toolbar1.setItems([doneBtn1], animated: true)
        timeTextView.inputAccessoryView = toolbar1
        timeTextView.inputView = timePIcker
        timePIcker.datePickerMode = .time
        
    }
    
    @objc func donePressed1(){
        
        let formatacao1 = DateFormatter()
        formatacao1.timeStyle = .short
        timeTextView.text = formatacao1.string(from: timePIcker.date)
        self.view.endEditing(true)
    }
    

}

extension SettingsViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        localTextField.isEnabled = false
        localTextField.borderStyle = .none
        localTextField.backgroundColor = #colorLiteral(red: 0.4957505465, green: 0.4904546738, blue: 0.9963564277, alpha: 1)
        self.save(local: localTextField.text ?? "")
        print(localization)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        localTextField.isEnabled = false
        localTextField.borderStyle = .none
        localTextField.backgroundColor = #colorLiteral(red: 0.4957505465, green: 0.4904546738, blue: 0.9963564277, alpha: 1)
        self.save(local: localTextField.text ?? "")
        print(localization)
        return true
    }
}
