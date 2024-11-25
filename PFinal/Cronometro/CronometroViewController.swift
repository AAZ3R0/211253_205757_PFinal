//
//  CronometroViewController.swift
//  PFinal
//
//  Created by alumno on 11/22/24.
//

import UIKit

//Clase que hereda un ViewController para asigar la vista como controladro
//También hereda TableViewDelegate y TableViewDataSource para poder utilizar tablas y datos en la vista
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
    //Cadena de texto que servirá para guardarlo en el label del cronómetro
    var cronometroString: String = ""
    //Variables booleanas que intercalarán los botones
    var IniciarPararC: Bool = true
    var añadirDetener: Bool = false
    
    
    //Variables de los label
    @IBOutlet weak var CronometroLabel: UILabel!
    @IBOutlet weak var lapsTableView: UITableView!
    
    @IBOutlet weak var btnIniciar: UIButton!
    @IBOutlet weak var Resetear: UIButton!
    
    //Función al picar el botón de inciar el cronómetro
    @IBAction func startStop(_ sender: Any) {
        
        //Si la variable es verdadera (Esta siempre iniciará como verdadera al comenzar la app)
        if IniciarPararC == true{
            
            //la variable timer guardará un horario de tiempo en el que se definirá el intervalo de tiempo, su objetivo es así mismo y el selector un método llamado actualizar cronómetro
            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(CronometroViewController.actualizarCronometro), userInfo: nil, repeats: true)
            //Una vez comienza la función, la varible se vulve falsa
            IniciarPararC = false
            //Cambia el texto visible en los botones
            btnIniciar.setTitle("Parar", for: UIControl.State.normal)
            Resetear.setTitle("Guardar", for: UIControl.State.normal)
            añadirDetener = true
        //Si por el contrario, la variable es falsa (Después de picar el botón se vuelve a picar)
        }else{
            //Invalidas el tiempo
            timer.invalidate()
            //Regresas esta variable a verdadera para tener ese ciclo
            IniciarPararC = true
            //Cambia el texto visible de los botones
            btnIniciar.setTitle("Iniciar", for: UIControl.State.normal)
            Resetear.setTitle("Resetear", for: UIControl.State.normal)
            añadirDetener = false
            
        }
    }
    
    
    //Función para resetear el tiempo, y guardar en una tabla el tiempo marcado en ese momento
    @IBAction func lapReset(_ sender: Any) {
        
        
        //Si esta varible es verdadera, va a guardar los datos en la lista
        if añadirDetener == true {
            
            guardados.insert(cronometroString, at: 0)
            //Recarga los datos de la tabla
            lapsTableView.reloadData()
            
        //De lo contrario, si añadirDetener es verdadera (Al iniciar la app siempre será falso)
        }else{
            //Se reasigna la variable como falsa
            añadirDetener = false
            //Cambia el texto del botón guardar a resetear
            Resetear.setTitle("Resetear", for: UIControl.State.normal)
            //Toda la tabla guardada se borrará
            guardados.removeAll(keepingCapacity: false)
            //Se actualizan los datos de la tabla
            lapsTableView.reloadData()
            
            //Se reasignan todos los valores de tiempo en 0 para mostrar en pantalla que se hizo un reset
            fracciones = 0
            segundos = 0
            minutos = 0
            horas = 0
            //También en la variable de cadena
            cronometroString = "00:00:00.00"
            //El texto del label que muestra el tiempo del cronómetro, guardará la variable anterior
            CronometroLabel.text = cronometroString
            
        }
    }
    
    //Al iniciar la vista, comenzará con todos los valores en 0
    override func viewDidLoad() {
        super.viewDidLoad()

        CronometroLabel.text = "00:00:00.00"
    }
    
    
    //Una función que hará que corra el tiempo
    @objc func actualizarCronometro(){
        //Al iniciar la función, se sumará en 1 el valor de fracciones
        fracciones += 1
        //Cuando llegue a 100
        if fracciones == 100{
            //Sumará en 1 el de segundos
            segundos += 1
            //El valor de fracciones vuelve a comenzar en 0
            fracciones = 0
        }
        
        //Cuando segundos llegue a 60
        if segundos == 60 {
            //Minutos sumará en 1
            minutos += 1
            //Los segundos volverán a 0
            segundos = 0
        }
        
        //Si los minutos llegan a 60
        if minutos == 60 {
            //La hora se suma en 1
            horas += 1
            //Los minutos vuelven a 0
            minutos = 0
        }
        
        //Si cada valor excede el número 9, le va a poner un 0 al final de la cadena
        let fraccionString = fracciones > 9 ? "\(fracciones)" : "0\(fracciones)"
        let segundosString = segundos > 9 ? "\(segundos)" : "0\(segundos)"
        let minutosString = minutos > 9 ? "\(minutos)" : "0\(minutos)"
        let horasString = horas > 9 ? "\(horas)" : "0\(horas)"
        
        //Concatenamos esta variable con todos los valores hechos, farmando la estructura del cronómetro
        cronometroString = "\(horasString):\(minutosString):\(segundosString).\(fraccionString)"
        //Le pasamos ese valor al label del cronómetro
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
