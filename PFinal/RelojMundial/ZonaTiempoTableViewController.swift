//
//  ZonaTiempoTableViewController.swift
//  PFinal
//
//  Created by alumno on 11/22/24.
//

import UIKit

protocol RelojMundialProtocol {
    func addZonaHoraria(zonaHoraria: String)
}

class ZonaTiempoTableViewController: UITableViewController, UISearchBarDelegate {
    
    
    var ZonaHoraria: [String] = []
    
    
    @IBOutlet weak var searchText: UISearchBar!
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    var delegate: RelojMundialProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        searchText.delegate = self
        
        ZonaHoraria = NSTimeZone.knownTimeZoneNames
    }
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ZonaHoraria.count
    }

    //Método que edita el aspecto de las rows
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        // Configure the cell...
        
        cell.textLabel?.text = ZonaHoraria[indexPath.row]

        return cell
    }
    
    //Método que selecciona rows
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let ZonaHorariaSeleccionada: String = ZonaHoraria[indexPath.row]
        delegate?.addZonaHoraria(zonaHoraria: ZonaHorariaSeleccionada)
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // Mark: - Métodos delegate del UISearchBar
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText != ""{
            
            ZonaHoraria = NSTimeZone.knownTimeZoneNames.filter{ $0.contains(searchText) }
            
        }else{
            
            ZonaHoraria = NSTimeZone.knownTimeZoneNames
            
        }
        
        tableView.reloadData()
        
    }

}
