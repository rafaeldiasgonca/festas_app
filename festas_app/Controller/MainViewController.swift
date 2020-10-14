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
    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var sharedButton: UIButton!
    
    var foodList:[String] = []
    var drinksList:[String] = []
    var disposableList:[String] = []
    var spaceList:[String] = []
    var utensilsList:[String] = []
    var randomList:[String] = []
    var rowsNumber = 3
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
        self.loadDataFood()
        self.loadDataSpace()
        self.loadDataDrinks()
        self.loadDataDisposable()
        self.loadDataUtensils()
    }
    
    func loadDataFood() {
        //1
        guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        //2
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Food")
        
        //3
        do {
            let results = try managedContext.fetch(fetchRequest)
            if(results.count > 0) {
                for i in 0...results.count - 1 {
                    let element = results[i].value(forKey: "toDo") as? String ?? ""
                    foodList.append(element)
                }
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func loadDataDrinks() {
        //1
        guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        //2
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Drinks")
        
        //3
        do {
            let results = try managedContext.fetch(fetchRequest)
            if (results.count > 0) {
                for i in 0...results.count - 1 {
                    let element = results[i].value(forKey: "toDo") as? String ?? ""
                    drinksList.append(element)
                }
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func loadDataUtensils() {
        //1
        guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        //2
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Utensils")
        
        //3
        do {
            let results = try managedContext.fetch(fetchRequest)
            if (results.count > 0) {
                for i in 0...results.count - 1 {
                    let element = results[i].value(forKey: "toDo") as? String ?? ""
                    utensilsList.append(element)
                }
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func loadDataDisposable() {
        //1
        guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        //2
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Disposable")
        
        //3
        do {
            let results = try managedContext.fetch(fetchRequest)
            if (results.count > 0) {
                for i in 0...results.count - 1 {
                    let element = results[i].value(forKey: "toDo") as? String ?? ""
                    disposableList.append(element)
                }
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func loadDataSpace() {
        //1
        guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        //2
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Space")
        
        //3
        do {
            let results = try managedContext.fetch(fetchRequest)
            if (results.count > 0) {
                for i in 0...results.count - 1 {
                    let element = results[i].value(forKey: "toDo") as? String ?? ""
                    spaceList.append(element)
                }
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    
    
    @IBAction func sharedButtonPressed(_ sender: UIButton) {
        sharedButton.alpha = 0
        let image = overView.getImage()
        sharedButton.alpha = 1
        // set up activity view controller
        let imageToShare = [ image ]
        let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash

        // exclude some activity types from the list (optional)
        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]

        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowsNumber
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        randomList = foodList + drinksList + spaceList + utensilsList + disposableList
        let cell = tableView.dequeueReusableCell(withIdentifier:"itens", for: indexPath) as! PartySummaryTableViewCell
        if randomList.count >= 3 {
            let random = Int.random(in: 0..<randomList.count)
            cell.LabelItens.text = randomList[random]
        } else if randomList.count == 2 {
                rowsNumber = 2
            cell.LabelItens.text = randomList[indexPath.row]
        } else if randomList.count == 1 {
            rowsNumber = 1
            cell.LabelItens.text = randomList[indexPath.row]
        } else {
            rowsNumber = 1
            cell.LabelItens.text = "Seus afazeres estão completos!"
        }
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
            startTimer(day: dayEvent, hour: hourEvent, minute: minuteEvent, month: monthEvent)
            if localName == "" {
                localNameLabel.text = "No location set"
            } else {
                localNameLabel.text = localName
            }
            typeNameLabel.text = typeName
            dayEventLabel.text = dayEvent
            if hourEvent == "" && minuteEvent == "" {
                timeEventLabel.text = "Undefined Schedule"
            } else {
                let timeEvent = hourEvent + ":" + minuteEvent
                timeEventLabel.text = timeEvent
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
        if intDays == 0, intHours == 0, intMinutes >= -30, intMinutes <= 0 {
            faltamLabel.text = ""
            countTimeLabel.text = "O evento está marcado para agora!"
        }
        
        if (intDays <= 0 && intHours <= 0 && intMinutes < -30) || (intDays <= 0 && intHours <= 0 && intMinutes < 0) {
            faltamLabel.text = ""
            countTimeLabel.text = "O evento já aconteceu"
        }
        if intDays >= 0 && intHours >= 0 && intMinutes > 0 {
            let countdown = "\(diffDateComponents.day ?? 0) dias, \(diffDateComponents.hour ?? 0) horas, \(diffDateComponents.minute ?? 0) minutos"
            countTimeLabel.text = countdown
        }
    }
    
}

extension UIView {
    func scale(by scale: CGFloat) {
        self.contentScaleFactor = scale
        for subview in self.subviews {
            subview.scale(by: scale)
        }
    }

    func getImage(scale: CGFloat? = nil) -> UIImage {
        let newScale = scale ?? UIScreen.main.scale
        self.scale(by: newScale)

        let format = UIGraphicsImageRendererFormat()
        format.scale = newScale

        let renderer = UIGraphicsImageRenderer(size: self.bounds.size, format: format)

        let image = renderer.image { rendererContext in
            self.layer.render(in: rendererContext.cgContext)
        }

        return image
    }
}
