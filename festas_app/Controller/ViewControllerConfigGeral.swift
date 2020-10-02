//
//  ViewControllerConfigGeral.swift
//  festas_app
//
//  Created by Rafael Dias Gonçalves on 01/10/20.
//  Copyright © 2020 Rafael Dias Gonçalves. All rights reserved.
//

import UIKit

class ViewControllerConfigGeral: UIViewController {

    @IBOutlet weak var ButtonExcluir: UIButton!
    @IBOutlet weak var ButtonFinalizar: UIButton!
    @IBOutlet weak var viewDetalhesConvidados: UIView!
    @IBOutlet weak var ViewDetalhesData: UIView!
    @IBOutlet weak var viewDetalhes: UIView!
    @IBOutlet weak var viewDetalhesTarefas: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ViewDetalhesData.layer.cornerRadius = 12
        self.viewDetalhes.layer.cornerRadius = 12
        self.viewDetalhesTarefas.layer.cornerRadius = 12
        self.viewDetalhesConvidados.layer.cornerRadius = 12
        self.ButtonExcluir.layer.cornerRadius = 12
        self.ButtonFinalizar.layer.cornerRadius = 12
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    


}
