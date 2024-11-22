//
//  RelojMundialTableViewController.swift
//  PFinal
//
//  Created by alumno on 11/22/24.
//

import UIKit



class RelojMundialTableViewController: UITableViewController, RelojMundialProtocol {
    
    var timeZonesPorMostrar: [String] = []
    
    
    
    func addZonaHoraria(zonaHoraria: String) {
        timeZonesPorMostrar.append(zonaHoraria)
        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
       
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return timeZonesPorMostrar.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ZonaTiempoTableViewCell

        // Configure the cell...
        
        
        cell.TimeZoneName.text = timeZonesPorMostrar[indexPath.row]
        

        return cell
    }
    

    //Te muestra el botón de editar
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    //Borrar un row al editar
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            timeZonesPorMostrar.remove(at: indexPath.row)
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    

    //Mover un row al editar
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let temp1 = timeZonesPorMostrar[fromIndexPath.row]
        let temp2 = timeZonesPorMostrar[to.row]
        
        timeZonesPorMostrar[fromIndexPath.row] = temp2
        timeZonesPorMostrar[to.row] = temp1
        
        tableView.reloadData()

    }
    

    
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }

    
    // MARK: - Navigation
    //Método para pasar el elemento de su vista orginaria a la siguiente
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "modalViewSegue"{
            
            let destino = segue.destination as! ZonaTiempoTableViewController
            destino.delegate = self
        }
    }
    

}
