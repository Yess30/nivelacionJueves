//
//  ViewController.swift
//  appAlumno
//
//  Created by Mac19 on 08/07/21.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    var alumno = [Alumnos]()
    var EnviarNombre: String?
    var EnviarCal: String?
    var EnviarNControl: Int64?
    var EnviarIndice: Int?
    var EnviarFoto: UIImage?
    
    let contexto = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var tablaAlumnos: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cargarCoreData()
        tablaAlumnos.reloadData()
        tablaAlumnos.register(UINib(nibName: "alumnosLTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("Aparecio la vista")
        tablaAlumnos.reloadData()
    }
    
    
    
    
    @IBAction func agregarAlumno(_ sender: UIBarButtonItem) {
        let alertaA = UIAlertController(title: "Agregar", message: "Agregar Alumno", preferredStyle: .alert)
        
        let accionAceptar = UIAlertAction(title: "Aceptar", style: .default) { (_) in
            
            guard let nombreAlert = alertaA.textFields?.first?.text else
            { return }
            guard let numControlAlert = Int64(alertaA.textFields?[1].text ?? "000000000") else
            { return }
            
            guard let califAlert = alertaA.textFields?.last?.text else
            {return}
            
            let imagenTemporal = UIImageView(image: #imageLiteral(resourceName: "emogi"))
            //Crear el obj para guardar un coredata
            
            let alumnoN = Alumnos(context: self.contexto)
            alumnoN.nombre = nombreAlert
            alumnoN.numControl = numControlAlert
            alumnoN.calificacion = califAlert
            alumnoN.foto = imagenTemporal.image!.pngData()

            self.alumno.append(alumnoN)
            self.guardarAlumno()
            self.tablaAlumnos.reloadData()
            
        }
        alertaA.addTextField { (nombreL) in
            nombreL.placeholder = "Nombre"
            nombreL.autocapitalizationType = .words
        }
        
        alertaA.addTextField { (numControlL) in
            numControlL.placeholder = "N° Control"
            numControlL.keyboardType = .numberPad
        }
        
        alertaA.addTextField { (calificacionL) in
            calificacionL.placeholder = "Calificacion"
        }
        
        
        
        alertaA.addAction(accionAceptar)
        
        let accionCancelar = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        
        alertaA.addAction(accionCancelar)
        
        present(alertaA, animated: true)
    }
    
    func guardarAlumno() {
        do {
            try contexto.save()
            print("Se guardo el contexto")
        } catch let error as NSError {
            print("Error al guardar:\(error.localizedDescription)")
        }
    }
    
    func cargarCoreData() {
        let fetchRequest: NSFetchRequest<Alumnos> = Alumnos.fetchRequest()
        do {
            alumno = try contexto.fetch(fetchRequest)
        } catch {
            print("Error al cargar datos de core data \(error.localizedDescription)")
        }
    }
    

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alumno.count
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tablaAlumnos.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! alumnosLTableViewCell
        
        celda.nombreL.text = alumno[indexPath.row].nombre
        celda.caliL.text = alumno[indexPath.row].calificacion
        celda.controlL.text = "\(alumno[indexPath.row].numControl )"
        celda.fotoA.image = UIImage(data: alumno[indexPath.row].foto! )
        
        
        return celda
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tablaAlumnos.deselectRow(at: indexPath, animated: true)
        EnviarNombre = alumno[indexPath.row].nombre
        EnviarCal = alumno[indexPath.row].calificacion
        EnviarNControl = alumno[indexPath.row].numControl
        EnviarIndice = indexPath.row
        EnviarFoto = UIImage(data: alumno[indexPath.row].foto!)
        performSegue(withIdentifier: "editarAlumno", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editarAlumno"{
            let objEditar = segue.destination as! EditarAlumnoViewController
            objEditar.recibirNombre = EnviarNombre
            objEditar.recibirnControl = EnviarNControl
            objEditar.recibirCal = EnviarCal
            objEditar.indice = EnviarIndice
            objEditar.recibirFoto = EnviarFoto
            objEditar.alumno = self.alumno
        }
    }
    
    
}
