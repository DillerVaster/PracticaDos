//
//  ViewController.swift
//  PracticaDos
//
//  Created by Victor E. Dill'Erva Torres on 24/04/17.
//  Copyright © 2017 Tecsup. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var fallas : [Falla] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do{
            try fallas = context.fetch(Falla.fetchRequest())
            tableView.reloadData()
        }
        catch{
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fallas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  UITableViewCell()
        let falla = fallas[indexPath.row]
        if falla.estado == "SinCorregir" {
            cell.textLabel?.text = falla.titulo
            cell.imageView?.image = UIImage(data: (falla.imagen!) as Data)
            cell.backgroundColor = UIColor.red
        }
        else {
            cell.textLabel?.text = falla.titulo
            cell.imageView?.image = UIImage(data: (falla.imagen!) as Data)
            cell.backgroundColor = UIColor.green
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let falla = fallas[indexPath.row]
        performSegue(withIdentifier: "fallaSegue", sender: falla)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let siguienteVC = segue.destination as! FallaViewController
        siguienteVC.falla = sender as? Falla
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete
        {
            
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            //let curso = Curso(context: context)
            context.delete(fallas[indexPath.row])
            fallas.remove(at: indexPath.row)
            
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            tableView.reloadData()
            navigationController!.popViewController(animated: true)
            
        }else if editingStyle == .insert {
            
        }
    }


}

