//
//  FallaViewController.swift
//  PracticaDos
//
//  Created by Victor E. Dill'Erva Torres on 24/04/17.
//  Copyright © 2017 Tecsup. All rights reserved.
//

import UIKit

class FallaViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var FallaImageView: UIImageView!
    @IBOutlet weak var tituloTextField: UITextField!
    @IBOutlet weak var descripcionTextField: UITextField!
    @IBOutlet weak var FallaImagen2: UIImageView!
    @IBOutlet weak var guardarActualizarBoton: UIButton!
    @IBOutlet weak var swCorregir: UISwitch!
    
    var imagePicker = UIImagePickerController()
    var imagePicker2 = UIImagePickerController()
    
    var falla : Falla? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        imagePicker2.delegate = self
        
        if falla != nil{
            FallaImageView.image = UIImage(data: (falla!.imagen!) as Data)
            tituloTextField.text = falla!.titulo
            descripcionTextField.text = falla!.descripcion
            //FallaImagen2.image = UIImage(data: (falla!.imagenFinal!) as Data)
            guardarActualizarBoton.setTitle("Corregir", for: .normal)
            //guardarActualizarBoton.isHidden = true
            swCorregir.isEnabled = true
        }
        else {
            swCorregir.isEnabled = false
        }
    }

    @IBAction func fotosTapped(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    @IBAction func camaraTapped(_ sender: Any) {
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }

    
    @IBAction func guardarTapped(_ sender: Any) {
        
        if falla != nil {
            falla!.titulo = tituloTextField.text
            falla!.imagen = UIImagePNGRepresentation(FallaImageView.image!) as NSData?
            falla!.descripcion = descripcionTextField.text
            falla!.estado = "Corregido"
            falla!.imagenFinal = UIImagePNGRepresentation(FallaImageView.image!) as NSData?
        }
        else {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let falla = Falla(context: context)
            falla.titulo = tituloTextField.text
            falla.imagen = UIImagePNGRepresentation(FallaImageView.image!) as NSData?
            falla.descripcion = descripcionTextField.text
            falla.estado = "SinCorregir"
            falla.imagenFinal = UIImagePNGRepresentation(FallaImageView.image!) as NSData?
        }
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController!.popViewController(animated: true)
    }

    @IBAction func corregir(_ sender: Any) {
        if falla != nil {
            falla!.titulo = tituloTextField.text
            falla!.imagen = UIImagePNGRepresentation(FallaImageView.image!) as NSData?
            falla!.descripcion = descripcionTextField.text
            falla!.estado = "Corregido"
            falla!.imagenFinal = UIImagePNGRepresentation(FallaImageView.image!) as NSData?
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let imagenSeleccionada = info[UIImagePickerControllerOriginalImage] as! UIImage
        FallaImageView.image = imagenSeleccionada
        FallaImagen2.image = imagenSeleccionada
        imagePicker.dismiss(animated: true, completion: nil)
        
    }
    
}
