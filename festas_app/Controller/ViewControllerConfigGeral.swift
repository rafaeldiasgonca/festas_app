//
//  ViewControllerConfigGeral.swift
//  festas_app
//
//  Created by Rafael Dias Gonçalves on 01/10/20.
//  Copyright © 2020 Rafael Dias Gonçalves. All rights reserved.
//

import UIKit
import CoreData

class ViewControllerConfigGeral: UIViewController {

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
    @IBOutlet weak var timeEventLabel: UILabel!
    
    
    var localName = String()
    var typeName = String()
    var dayEvent = String()
    var monthEvent = String()
    var hourEvent = String()
    var minuteEvent = String()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ViewDetalhesData.layer.cornerRadius = 12
        self.viewDetalhes.layer.cornerRadius = 12
        self.viewDetalhesTarefas.layer.cornerRadius = 12
        self.viewDetalhesConvidados.layer.cornerRadius = 12
        self.ButtonExcluir.layer.cornerRadius = 12
        self.ButtonFinalizar.layer.cornerRadius = 12
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
            timeEventLabel.text = timeEvent
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
    
    
    @IBAction func editDetailsButton(_ sender: UIButton) {
        if sender.tag == 1 {
            sender.tag = 2
            typeNameTextField.isEnabled = true
            localNameTextField.isEnabled = true
        } else {
            sender.tag = 1
            typeNameTextField.isEnabled = false
            localNameTextField.isEnabled = false
        }
    }
    


}
