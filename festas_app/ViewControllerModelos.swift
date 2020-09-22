//
//  ViewControllerModelos.swift
//  festas_app
//
//  Created by Rafael Dias Gonçalves on 22/09/20.
//  Copyright © 2020 Rafael Dias Gonçalves. All rights reserved.
//

import UIKit

class ViewControllerModelos: UIViewController {
    @IBOutlet weak var ViewChurrasco: UIView!
    @IBOutlet weak var ViewAniversario: UIView!
    @IBOutlet weak var ViewReuniaoDeAmigos: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ViewChurrasco.layer.cornerRadius = 12
        ViewReuniaoDeAmigos.layer.cornerRadius = 12
        ViewAniversario.layer.cornerRadius = 12
    }
    

   

}
