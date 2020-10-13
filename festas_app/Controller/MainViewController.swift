//
//  ViewControllerInicio.swift
//  festas_app
//
//  Created by Rafael Dias Gonçalves on 30/09/20.
//  Copyright © 2020 Rafael Dias Gonçalves. All rights reserved.
//

import UIKit
import CoreData

class MainViewController: UIViewController, UITableViewDataSource {
    
    
    var itens:[String] = ["","",""]
    @IBOutlet weak var viewPrincipal: UIView!
    @IBOutlet weak var viewDetalhesData: UIView!
    @IBOutlet weak var viewDetalhes: UIView!
    @IBOutlet weak var tableViewDetalhes: UITableView!
    @IBOutlet weak var typeNameLabel: UILabel!
    @IBOutlet weak var localNameLabel: UILabel!
    @IBOutlet weak var dayEventLabel: UILabel!
    @IBOutlet weak var monthEventLabel: UILabel!
    @IBOutlet weak var timeEventLabel: UILabel!
    @IBOutlet weak var countTimeLabel: UILabel!
    @IBOutlet weak var faltamLabel: UILabel!
    
    var releaseDate: NSDate?
    var countdownTimer = Timer()
    var localName = String()
    var typeName = String()
    var dayEvent = "00"
    var monthEvent = String()
    var hourEvent = String()
    var minuteEvent = String()
    let calendar = Calendar.current
    let date = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Ola,festeiro"
        UserDefaults.standard.set(true, forKey: "ALLREADY_REGISTER")
        navigationItem.largeTitleDisplayMode = .always
        self.viewDetalhes.layer.cornerRadius = 12
        self.viewPrincipal.layer.cornerRadius = 12
        self.viewDetalhesData.layer.cornerRadius = 12
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"itens", for: indexPath) as! PartySummaryTableViewCell
        cell.LabelItens.text = itens[indexPath.row]
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
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
            localNameLabel.text = localName
            typeNameLabel.text = typeName
            dayEventLabel.text = dayEvent
            let timeEvent = hourEvent + ":" + minuteEvent
            startTimer(day: dayEvent, hour: hourEvent, minute: minuteEvent, month: monthEvent)
            
            timeEventLabel.text = timeEvent
            switch monthEvent {
            case "01":
                monthEventLabel.text = "JAN"
            case "02":
                monthEventLabel.text = "FEB"
            case "03":
                monthEventLabel.text = "MAR"
            case "04":
                monthEventLabel.text = "ABR"
            case "05":
                monthEventLabel.text = "MAY"
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
                monthEventLabel.text = "UND"
            }
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    
    func startTimer(day: String, hour:String, minute:String, month:String) {
        let year = calendar.component(.year, from: date)
        let stringYear = String(year)
        let releaseDateString = stringYear + "-" + month + "-" + day + " " + hour + ":" + minute + ":00"
        print(releaseDateString)
        let releaseDateFormatter = DateFormatter()
        releaseDateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        releaseDate = releaseDateFormatter.date(from: releaseDateString) as NSDate?
        if releaseDate != nil {
            countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
            faltamLabel.text = "Faltam"
        } else {
            faltamLabel.text = ""
            countTimeLabel.text = ""
        }
    }
    
    @objc func updateTime() {
        
        let currentDate = Date()
        let calendar = Calendar.current
        
        let diffDateComponents = calendar.dateComponents([.day, .hour, .minute, .second], from: currentDate, to: releaseDate! as Date)
        let intDays = Int(diffDateComponents.day ?? 0)
        let intMinutes = Int(diffDateComponents.minute ?? 0)
        let intHours = Int(diffDateComponents.hour ?? 0)
        if intDays == 0, intHours == 0, intMinutes == 0 {
            faltamLabel.text = ""
            countTimeLabel.text = "O evento está marcado para agora!"
        } else if intDays < 0, intHours < 1, intMinutes < 0 {
            faltamLabel.text = ""
            countTimeLabel.text = "O evento já aconteceu"
        } else {
            let countdown = "\(diffDateComponents.day ?? 0) dias, \(diffDateComponents.hour ?? 0) horas, \(diffDateComponents.minute ?? 0) minutos"
            countTimeLabel.text = countdown
        }
    }
    
    
    
}
