//
//  ZonaTiempoTableViewController.swift
//  PFinal
//
//  Created by alumno on 11/22/24.
//

import UIKit

//Protocolo que sirve para añadir elementos en la lista personalizada
protocol RelojMundialProtocol {
    //Función para añadir la zona horario usando una variable de tipo String
    func addZonaHoraria(zonaHoraria: String)
}

//Clase de tipo UITableViewController y UISearchBarDelegate para acceder a una vista de tabla y a una barra de búsqueda
class ZonaTiempoTableViewController: UITableViewController, UISearchBarDelegate {
    
    //Variable de tipo cadena con nombre ZonaHoraria
    var ZonaHoraria: [String] = []
    
    //Variable débil que hace referencia a la barra de búsqueda
    @IBOutlet weak var searchText: UISearchBar!
    
    //Función de tipo "sobreescribir" booleana para decir que si la barra de búsqueda esté invisible
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    //Hace un delegate al protocolo para poder realizar la función de búsqueda de manera general
    var delegate: RelojMundialProtocol?

    //Función principal de tipo "sobreescribir" para pode® realizar la búsqueda con un dato predeterminado
    //de zonas horarias
    override func viewDidLoad() {
        super.viewDidLoad()
        //Parámetro que sirve para poder llevar a cabo la búsqueda por sí misma
        searchText.delegate = self
        
        //Variable que guardará el filtro de búsqueda que accede a la lista de los nombres de los países
        ZonaHoraria = NSTimeZone.knownTimeZoneNames
    }
    
    

    // MARK: - Table view data source

    //Función que es para personalizar la cantidad de renglones
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    //Función que es para personalizar la cantidad de columnas
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        //Regresa la cantidad de columnas de acuerdo a la variable
        return ZonaHoraria.count
    }

    //Método que edita el aspecto de las rows
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Variable de tipo cell con identificador que se basa en un elemento IndexPath
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        // Configure the cell...
        //Constante cell de tipo texto que se basa en lo que hay en cada renglón
        cell.textLabel?.text = ZonaHoraria[indexPath.row]

        //Regresa la constante
        return cell
    }
    
    //Método que selecciona rows
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Variable constante que es una cadena de ZonaHoraria basada en lo que hay en cada renglón
        let ZonaHorariaSeleccionada: String = ZonaHoraria[indexPath.row]
        //Mencionando que es para lograr el filtro de búsqueda con delegate
        delegate?.addZonaHoraria(zonaHoraria: ZonaHorariaSeleccionada)
        //Animación de los rows
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // Mark: - Métodos delegate del UISearchBar
    //Función que lleva a cabo la animación del elemento Cancelar en la barra de búsqueda
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        //Animación del elemento Cancelar
        self.dismiss(animated: true, completion: nil)
    }
    
    //Función de la barra de búsqueda con condiciones que se relacionan al escribir o al no hacerlo
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //Dando la condición de que si hay texto accederá al filtro de búsqueda de acuerdo a lo insertado
        if searchText != ""{
            //Variable del filtro de búsqueda aproximado
            ZonaHoraria = NSTimeZone.knownTimeZoneNames.filter{ $0.contains(searchText) }
            
        }
        //De lo contrario, mostrará toda la lista de los países
        else{
            //Variable del filtro de búsqueda completo
            ZonaHoraria = NSTimeZone.knownTimeZoneNames
            
        }
        //Recarga de los datos de la vista de tabla
        tableView.reloadData()
        
    }

}
