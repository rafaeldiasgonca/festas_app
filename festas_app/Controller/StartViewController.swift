//
//  ViewController.swift
//  festas_app
//
//  Created by Rafael Dias Gonçalves on 22/09/20.
//  Copyright © 2020 Rafael Dias Gonçalves. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

    @IBOutlet weak var startCard: UIView!
    @IBOutlet weak var stardCardButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "BalooBhai2-ExtraBold", size: 34) as Any]
        UserDefaults.standard.set(false, forKey: "ALLREADY_REGISTER")
        UIAccessibility.post(notification: .announcement, argument: "Olá, novato. Vamos criar uma festa?")
    }

}

