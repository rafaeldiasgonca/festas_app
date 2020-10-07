//
//  ListaDoQueFazerViewController.swift
//  festas_app
//
//  Created by Rafael Dias Gonçalves on 02/10/20.
//  Copyright © 2020 Rafael Dias Gonçalves. All rights reserved.
//

import UIKit

class ListaDoQueFazerViewController: UIViewController,UITableViewDelegate,UITableViewDataSource, UITextFieldDelegate{
    @IBOutlet weak var tableViewToDoList: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Oque Fazer"
    }
    var churrascoToDo = [["Decidir que Carnes usar","Mensurar quantidade de carnes","Comprar carnes","Decidir que tempero de carne usar","Comprar temperos","Comprar carvão"],["Decidir que bebidas comprar","Comprar bebidas","Comprar gelo"],["Comprar copos","Comprar pratos","Comprar espetinhos","Comprar talheres"],["Verificar se há amoladores","Verificar talheres","Verificar pegadores","Veridicar facas","Verificar tábuas"],["Verificar cadeiras","Alugar cadeiras","Verificar mesas","Alugar mesas","Verificar Local","Alugar local","Preparar local"]]
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return churrascoToDo[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let  cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ToDoTableViewCell
        cell.textFieldToDo.text = churrascoToDo[indexPath.section][indexPath.row]
        cell.itensTF.delegate = self
        return cell
    }
       
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
             
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height:100))
           
       
        let label = UILabel(frame: CGRect(x: 5 , y: 5, width: 100, height: 15))
        label.tag = section
        headerView.addSubview(label)
        
        
       let button = UIButton(frame: CGRect(x: 360, y: 10, width: 10, height: 11))
        button.tag = section
        button.setImage(UIImage(named: "remove_button"), for: UIControl.State.normal)
        button.backgroundColor = .blue
        headerView.addSubview(button)
        
        switch section {
        case 0:
            
            button.addTarget(self,action:#selector(comidaBut),for:.touchUpInside)
            label.text = "Comidas"
            return headerView
        case 1:
            button.addTarget(self,action:#selector(bebidasBut),for:.touchUpInside)
            label.text = "Bebidas"
            return headerView
        case 2:
            button.addTarget(self,action:#selector(utensiliosBut),for:.touchUpInside)
            label.text = "Utensilios"
            return headerView
        case 3:
            button.addTarget(self,action:#selector(descartaveisBut),for:.touchUpInside)
            label.text = "Descartaveis"
            return headerView
        case 4:
            button.addTarget(self,action:#selector(espacosBut),for:.touchUpInside)
            label.text = "Espaços"
            return headerView
        default:
            return headerView
        }
            

        
    }
    @objc func comidaBut(sender:UIButton)
    {

        
        print("comidaButClicked")
    }
    
    @objc func bebidasBut(sender:UIButton)
    {
        if(sender.tag == 1){

           //Do something for tag 1
        }
        print("bebidasButClicked")
    }
    
    @objc func utensiliosBut(sender:UIButton)
    {
        if(sender.tag == 1){

           //Do something for tag 1
        }
        print("utensiliosButClicked")
    }
    
    @objc func descartaveisBut(sender:UIButton)
    {
        if(sender.tag == 1){

           //Do something for tag 1
        }
        print("descartaveisButClicked")
    }
    
    @objc func espacosBut(sender:UIButton)
    {
        if(sender.tag == 1){

           //Do something for tag 1
        }
        print("espaçosButClicked")
    }

    
        }
        
