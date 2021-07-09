//
//  EditarAlumnoViewController.swift
//  appAlumno
//
//  Created by Mac19 on 08/07/21.
//

import UIKit

class EditarAlumnoViewController: UIViewController {
    var alumno = [Alumnos]()
    
    var recibirNombre: String?
    var recibirnControl: Int64?
    var recibirCal: String?
    var recibirFoto: UIImage?
    var indice: Int?
    
    let contexto = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    @IBOutlet weak var fotoAlumno: UIImageView!
    @IBOutlet weak var nombreL: UITextField!
    @IBOutlet weak var numControlL: UITextField!
    @IBOutlet weak var calificacionL: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nombreL.text = recibirNombre
        nombreL.isUserInteractionEnabled = false
        numControlL.text = "\(recibirnControl ?? 000000000)"
        numControlL.isUserInteractionEnabled = false
        fotoAlumno.image = recibirFoto
        calificacionL.text = recibirCal
       
        // Do any additional setup after loading the view.
        let Tap = UITapGestureRecognizer(target: self, action: #selector(DismissKeyboard))
        view.addGestureRecognizer(Tap)
        let gestura = UITapGestureRecognizer(target: self, action: #selector(clickImagen))
        
        gestura.numberOfTapsRequired = 1
        gestura.numberOfTouchesRequired = 1
        fotoAlumno.addGestureRecognizer(gestura)
        fotoAlumno.isUserInteractionEnabled = true
    }
    
    @objc func DismissKeyboard() {
        view.endEditing(true)
    }
    
    
    @objc func clickImagen(gestura: UITapGestureRecognizer){
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func EditarButton(_ sender: UIButton) {
        do {
          //  self.alumno[indice!].setValue(nombreL.text, forKey: "nombre")
          //  self.alumno[indice!].setValue(Int64(numControlL.text!), forKey: "numControl")
            self.alumno[indice!].setValue(calificacionL.text, forKey: "calificacion")
            self.alumno[indice!].setValue(fotoAlumno.image?.pngData(), forKey: "foto")
          
            
            
            try self.contexto.save()
        } catch {
            print("Error al actualizar: \(error.localizedDescription)")
        }
        navigationController?.popViewController(animated: true)
        
    }
    
}
//protocolo gestura
extension EditarAlumnoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let imagenSelec = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage{
            fotoAlumno.image = imagenSelec
        }
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
