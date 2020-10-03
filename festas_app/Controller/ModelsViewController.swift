//
//  ViewControllerModelos.swift
//  festas_app
//
//  Created by Rafael Dias Gonçalves on 22/09/20.
//  Copyright © 2020 Rafael Dias Gonçalves. All rights reserved.
//

import UIKit
var titulo = String()
class ModelsViewController: UIViewController {
    @IBOutlet weak var ViewChurrasco: UIView!
    @IBOutlet weak var ViewAniversario: UIView!
    @IBOutlet weak var ViewReuniaoDeAmigos: UIView!
    let models = [1:"Reuniao de amigos", 2:"Churrasco", 3:"Aniversario"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ViewChurrasco.layer.cornerRadius = 12
        ViewReuniaoDeAmigos.layer.cornerRadius = 12
        ViewAniversario.layer.cornerRadius = 12
    }
    
    @IBAction func modelTypePressed(_ sender: UIButton) {
        titulo = models[sender.tag]!
        self.performSegue(withIdentifier: "goToSettingsMenu", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let newVc:SettingsViewController = segue.destination as! SettingsViewController
        newVc.tituloRecebido = titulo
    }
    
}
