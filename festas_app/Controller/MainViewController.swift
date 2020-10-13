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
    
    @IBAction func sharedButtonPressed(_ sender: UIButton) {
        let image = overView.getImage()

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
            startTimer(day: dayEvent, hour: hourEvent, minute: minuteEvent, month: monthEvent)
            if localName == "" {
                localNameLabel.text = "Local indefinido"
            } else {
                localNameLabel.text = localName
            }
            typeNameLabel.text = typeName
            dayEventLabel.text = dayEvent
            if hourEvent == "" && minuteEvent == "" {
                timeEventLabel.text = "Horario Indefinido"
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
