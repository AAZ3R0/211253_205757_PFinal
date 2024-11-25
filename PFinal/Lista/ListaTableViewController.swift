//
//  TableViewController.swift
//  PFinal
//
//  Created by alumno on 11/25/24.
//

import UIKit

//Clase que tiene como herencia ser un controlador de TableView y Barra de búsqueda delegado
class ListaTableViewController: UITableViewController, UISearchBarDelegate {
    
    //String que guarda el enlace de la api
    let url_api = "https://restcountries.com/v3.1/all?fields=name,flag"
    //Arreglo de tipo Pais
    var paises: [Pais] = []
    //Arreglo que se va a mostrar cuando usemos la barra de búsqueda
    var paises_filtrados: [Pais] = []
    
    //Variable referenciada al texto introducido en la barra de búsqueda
    @IBOutlet weak var SearchText: UISearchBar!
    
    
    
    //Método que inicializa a la hora de mostrarse la vista
    override func viewDidLoad() {
        super.viewDidLoad()
        //Es lo que permitirá hacer el filtro de búsqueda al texto de la barra de búsqueda
        SearchText.delegate = self
        //Una constante que guardará el método URL y que como argumento tendrá la constante donde se guarda el enlace de la api
        let ubicacion = URL(string: url_api)!
        //Método URLSession para conectarse a al api de datos, con la anterior constante como parámetro
        URLSession.shared.dataTask(with: ubicacion) {
            //Respectivamente tendrá parámetros que podemos nombrar como queramos para mejor ubicación
            (datos, respuesta, error) in do{
                //Si los datos se recibieron correctamente
                if let lista_recibida = datos{
                    //Creas una constante que intente guardar la decodificación de datos JSON en el arreglo de tipo Pais
                    let interpretacion_datos = try JSONDecoder().decode([Pais].self, from: lista_recibida)
                    //Ejecutamos un método que haga la tarea de mostrar esos datos de manera asíncrona
                    DispatchQueue.main.async{
                        //La variable paises guarda la variable en la que se decodificaron los datos JSON al arrelog de tipo país
                        self.paises = interpretacion_datos
                        self.paises_filtrados = interpretacion_datos
                        //Ejecutamos otro método en el que me recargue los datos de la tabla visible
                        DispatchQueue.main.async{
                            self.tableView.reloadData()
                        }
                    }
                 //De lo contrario, me mostrará una respuesta en la que no se accedió correctamente a la api, pero esta funciona
                }else{
                    print(respuesta!)
                    
                }
                //Muestra algún error de porque no dejó acceder a la api
            }catch{
                print(error)
            }
            //Para inicializar la tarea URLSession
        }.resume()
    }

    // MARK: - Table view data source
    
    //Retorna la cantidad de veces el mismo dato de la tabla
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    //Retorna el número de columnas en el elemento de TableView
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // retorna la cantidad de países que hay
        return self.paises_filtrados.count
    }

    //Retorna los datos de manera visible y enlaza la vista de la celda en la tabla
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ListaTableViewCell
        let pais = self.paises_filtrados[indexPath.row]
        cell.Nombre.text = pais.name.common
        cell.Bandera.text = pais.flag

        return cell
    }
    
    //Métodos para filtrar una búsqueda aproximada por el nombre
    
    //Método que muestra un botón para cancelar la búsqueda/borrar el texto dentro de la barra
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //Función que hará el filtro de búsqueda
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        //Si el texto de la barra de búsqueda está vacío
        if searchText.isEmpty{
            
            //El arreglo que filtrará la búsqueda se quedará igual al arreglo original
            paises_filtrados = paises
            
        }else{
            
            //El segundo arreglo guardará que en el primer arreglo invoca un método llamado filter en el que accede al nombre y activa el método contains, especificando que busque de manera aproximada.
            paises_filtrados = paises.filter{$0.name.common.lowercased().contains(searchText.lowercased())}
            
            
            
        }
        
        //Después de cualquiera de las dos cosas ocurra, recarga los datos de la entrega.
        tableView.reloadData()
        
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
