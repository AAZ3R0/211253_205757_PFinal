//
//  TableViewController.swift
//  PFinal
//
//  Created by alumno on 11/25/24.
//

import UIKit

class ListaTableViewController: UITableViewController, UISearchBarDelegate {
    
    let url_api = "https://restcountries.com/v3.1/all?fields=name,flag"
    var paises: [Pais] = []
    var paises_filtrados: [Pais] = []
    
    @IBOutlet weak var SearchText: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SearchText.delegate = self
        
        
        let ubicacion = URL(string: url_api)!
        URLSession.shared.dataTask(with: ubicacion) {
            (datos, respuesta, error) in do{
                if let lista_recibida = datos{
                    let interpretacion_datos = try JSONDecoder().decode([Pais].self, from: lista_recibida)
                    DispatchQueue.main.async{
                        self.paises = interpretacion_datos
                        self.paises_filtrados = interpretacion_datos
                        DispatchQueue.main.async{
                            self.tableView.reloadData()
                        }
                    }
                    
                }else{
                    print(respuesta!)
                    
                }
            }catch{
                print(error)
            }
        }.resume()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.paises_filtrados.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ListaTableViewCell
        let pais = self.paises_filtrados[indexPath.row]
        cell.Nombre.text = pais.name.common
        cell.Bandera.text = pais.flag

        return cell
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmpty{
            
            paises_filtrados = paises
            
        }else{
            
            paises_filtrados = paises.filter{$0.name.common.lowercased().contains(searchText.lowercased())}
            
            
            
        }
        
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
