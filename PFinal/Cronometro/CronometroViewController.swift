//
//  CronometroViewController.swift
//  PFinal
//
//  Created by alumno on 11/22/24.
//

import UIKit

class CronometroViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    //Variable que va a guardar los cronómetros guardados
    var guardados: [String] = []
    
    //Variable que contará el tiempo
    var timer = Timer()
    //Variables que guadarán cada elemento que conforma el tiempo
    var horas = 0
    var minutos = 0
    var segundos = 0
    var fracciones = 0
    
    var cronometroString: String = ""
    //Variables booleanas que intercalarán los botones
    var IniciarPararC: Bool = true
    var añadirDetener: Bool = false
    
    
    
    @IBOutlet weak var CronometroLabel: UILabel!
    @IBOutlet weak var lapsTableView: UITableView!
    
    @IBOutlet weak var btnIniciar: UIButton!
    @IBOutlet weak var Resetear: UIButton!
    
    
    @IBAction func startStop(_ sender: Any) {
        
        if IniciarPararC == true{
            
            
            
            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(CronometroViewController.actualizarCronometro), userInfo: nil, repeats: true)
            IniciarPararC = false
            
            btnIniciar.setTitle("Parar", for: UIControl.State.normal)
            Resetear.setTitle("Guardar", for: UIControl.State.normal)
            añadirDetener = true
        }else{
            timer.invalidate()
            IniciarPararC = true
            
            btnIniciar.setTitle("Iniciar", for: UIControl.State.normal)
            Resetear.setTitle("Resetear", for: UIControl.State.normal)
            añadirDetener = false
            
        }
    }
    
    @IBAction func lapReset(_ sender: Any) {
        
        if añadirDetener == true {
            
            guardados.insert(cronometroString, at: 0)
            lapsTableView.reloadData()
        }else{
            añadirDetener = false
            Resetear.setTitle("Resetear", for: UIControl.State.normal)
            
            guardados.removeAll(keepingCapacity: false)
            
            lapsTableView.reloadData()
            
            fracciones = 0
            segundos = 0
            minutos = 0
            horas = 0
            
            cronometroString = "00:00:00.00"
            CronometroLabel.text = cronometroString
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        CronometroLabel.text = "00:00:00.00"
    }
    
    @objc func actualizarCronometro(){
        fracciones += 1
        if fracciones == 100{
            segundos += 1
            fracciones = 0
        }
        
        if segundos == 60 {
            minutos += 1
            segundos = 0
        }
        
        if minutos == 60 {
            horas += 1
            minutos = 0
        }
        
        let fraccionString = fracciones > 9 ? "\(fracciones)" : "0\(fracciones)"
        let segundosString = segundos > 9 ? "\(segundos)" : "0\(segundos)"
        let minutosString = minutos > 9 ? "\(minutos)" : "0\(minutos)"
        let horasString = horas > 9 ? "\(horas)" : "0\(horas)"
        
        cronometroString = "\(horasString):\(minutosString):\(segundosString).\(fraccionString)"
        CronometroLabel.text = cronometroString
    }
    
    
    //Métodos de tabla
    
    
    
    /*
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
    }
    */
    
    //Cambia el estilo del elemento
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "cell")
        cell.backgroundColor = self.view.backgroundColor//No Cambia nada :D
        
        cell.textLabel!.text = "Tiempo \(guardados.count-indexPath.row)"
        cell.detailTextLabel?.text = guardados[indexPath.row]
        
        return cell
    }
    
    
    //Regresa el número de renglones o elementos
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return guardados.count
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
