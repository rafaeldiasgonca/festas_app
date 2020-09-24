//
//  ViewControllerConfiguracao.swift
//  festas_app
//
//  Created by Rafael Dias Gonçalves on 22/09/20.
//  Copyright © 2020 Rafael Dias Gonçalves. All rights reserved.
//

import UIKit



class ViewControllerConfiguracao: UIViewController {
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var timeTextField: UITextField!
    
    let datePicker = UIDatePicker()
    let timePIcker = UIDatePicker()
    
    var tituloRecebido = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = tituloRecebido
        createDatePickerView()
        createTimePickerView()
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
        dateTextField.inputAccessoryView = toolBar
        //assign datePicker to textField
        dateTextField.inputView = datePicker
        datePicker.datePickerMode  = .date
    }
    @objc func donePressed(){
        let formatacao = DateFormatter()
        formatacao.dateStyle = .long
        formatacao.timeStyle = .none
        dateTextField.text = formatacao.string(from: datePicker.date)
        self.view.endEditing(true)
        
    }
    func createTimePickerView(){
        let toolbar1 = UIToolbar()
        toolbar1.sizeToFit()
        let doneBtn1 = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed1))
        toolbar1.setItems([doneBtn1], animated: true)
        timeTextField.inputAccessoryView = toolbar1
        timeTextField.inputView = timePIcker
        timePIcker.datePickerMode = .time
        
    }
    @objc func donePressed1(){
        
        let formatacao1 = DateFormatter()
    
        formatacao1.timeStyle = .short
        timeTextField.text = formatacao1.string(from: timePIcker.date)
        
    }
    

}
