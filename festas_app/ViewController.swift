//
//  ViewController.swift
//  festas_app
//
//  Created by Rafael Dias Gonçalves on 22/09/20.
//  Copyright © 2020 Rafael Dias Gonçalves. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var startCard: UIView!
    @IBOutlet weak var stardCardButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startCard.layer.cornerRadius = 12
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController!.navigationBar.isTranslucent = true
    }

    @IBAction func startCardAnimated(_ sender: UIButton) {
        stardCardButton.backgroundColor = .black
        stardCardButton.alpha = 0.5
    }
    
    @IBAction func startCardPressed(_ sender: UIButton) {
        stardCardButton.alpha = 0.0
    }

}

