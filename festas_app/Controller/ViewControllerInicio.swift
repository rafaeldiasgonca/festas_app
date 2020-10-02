//
//  ViewControllerInicio.swift
//  festas_app
//
//  Created by Rafael Dias Gonçalves on 30/09/20.
//  Copyright © 2020 Rafael Dias Gonçalves. All rights reserved.
//

import UIKit

class ViewControllerInicio: UIViewController,UITableViewDataSource{
    
    
    var itens:[String] = ["","",""]
    @IBOutlet weak var viewPrincipal: UIView!
    @IBOutlet weak var viewDetalhesData: UIView!
    @IBOutlet weak var viewDetalhes: UIView!
    @IBOutlet weak var tableViewDetalhes: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Ola,festeiro"
        navigationItem.largeTitleDisplayMode = .always
        self.viewDetalhes.layer.cornerRadius = 12
        self.viewPrincipal.layer.cornerRadius = 12
        self.viewDetalhesData.layer.cornerRadius = 12
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"itens", for: indexPath) as!PartySummaryTableViewCell
        cell.LabelItens.text = itens[indexPath.row]
        return cell
    }
   

}
