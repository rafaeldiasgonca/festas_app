//
//  ListaDoQueFazerViewController.swift
//  festas_app
//
//  Created by Rafael Dias Gonçalves on 02/10/20.
//  Copyright © 2020 Rafael Dias Gonçalves. All rights reserved.
//

import UIKit

class ListaDoQueFazerViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
   
    

    @IBOutlet weak var TableViewEspacos: UITableView!
    @IBOutlet weak var TableViewUtensilios: UITableView!
    @IBOutlet weak var tableViewdescartaveis: UITableView!
    @IBOutlet weak var TableViewBebidas: UITableView!
    @IBOutlet weak var tableViewComida: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //declarando o delegate de cada tableView
        TableViewEspacos.delegate = self
        tableViewdescartaveis.delegate = self
        tableViewComida.delegate = self
        TableViewBebidas.delegate = self
        TableViewUtensilios.delegate = self
        //Declarando o dataSource de cada tableView
        TableViewEspacos.dataSource = self
        tableViewdescartaveis.dataSource = self
        tableViewComida.dataSource = self
        TableViewBebidas.dataSource = self
        TableViewUtensilios.dataSource = self
        
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberOfRow = 1
        switch tableView{
        
        case TableViewEspacos:
            numberOfRow = 2
        case tableViewdescartaveis:
            numberOfRow = 2
        case tableViewComida:
            numberOfRow = 2
        case TableViewBebidas:
            numberOfRow = 2
        case TableViewUtensilios:
            numberOfRow = 2
        default:
            print("algo errado")
        }
        return numberOfRow
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       var  cell = UITableViewCell()
        switch tableView {
        case TableViewEspacos:
            cell = tableView.dequeueReusableCell(withIdentifier:"Espacos", for: indexPath)
        case tableViewdescartaveis:
            cell = tableView.dequeueReusableCell(withIdentifier:"descartaveis", for: indexPath)
        case tableViewComida:
            cell = tableView.dequeueReusableCell(withIdentifier:"Comida", for: indexPath)
        case TableViewBebidas:
            cell = tableView.dequeueReusableCell(withIdentifier:"Bebidas", for: indexPath)
        case TableViewUtensilios:
            cell = tableView.dequeueReusableCell(withIdentifier:"utensilios", for: indexPath)
            
        default:
            print("erro")
        }
        return cell
    }

}
