//
//  TemporizadorViewController.swift
//  PFinal
//
//  Created by alumno on 11/22/24.
//

import UIKit

class TemporizadorViewController: ViewController {
    
    //Variables de la etiqueta del tiempo y botones
    @IBOutlet weak var TempoLabel: UILabel!
    
    @IBOutlet weak var IniciarPararBtn: UIButton!
    @IBOutlet weak var ResetearBtn: UIButton!
    
    //Variable que guardará el tiempo
    
    var timer: Timer = Timer()
    var count: Int = 0
    var CuentaDeTiempo: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
    }
    
    //Funciones al picarle los botones
    
    
    @IBAction func IniciarParar(_ sender: Any) {
        
        if (CuentaDeTiempo){
            CuentaDeTiempo = false
            timer.invalidate()
            IniciarPararBtn.setTitle("Resetear", for: .normal)
        }else{
            
            CuentaDeTiempo  = true
            IniciarPararBtn.setTitle("Inicar", for: .normal)
            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(TemporizadorViewController.ContadorDeTiempo), userInfo: nil, repeats: true)
        }
        
    }
    
    
    @IBAction func Resetear(_ sender: Any) {
        
        let alerta = UIAlertController(title: "¿Resetear temporizador?", message: "¿Estás seguro de que quieres resetearlo?", preferredStyle: .alert)
        alerta.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: {(_) in
            // ¿Qué hace?
            // Nada *Mueve girando las manos*
            
        }))
        
        alerta.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: {(_) in
            self.count = 0
            self.timer.invalidate()
            self.TempoLabel.text = self.CrearTiempoString(hora: 0, minutos: 0, segundos: 0, fraccion: 0)
            self.IniciarPararBtn.setTitle("Parar", for: .normal)
            
            
        }))
        
        self.present(alerta, animated: true, completion: nil)
        
    }
    
    @objc func ContadorDeTiempo() -> Void
    {
        count = count + 1
        let tiempo = segundosParaHorasMinutosSegundos(segundos: count)
        let tiempoString = CrearTiempoString(hora: tiempo.0, minutos: tiempo.1, segundos: tiempo.2, fraccion: tiempo.3)
        TempoLabel.text = tiempoString
    }
    
    func segundosParaHorasMinutosSegundos(segundos: Int) -> (Int, Int, Int, Int)
    {
        return ((segundos / 3600), ((segundos & 3600) / 60), ((segundos & 3600) % 60), ((segundos & 3600) % 100))
    }
    
    func CrearTiempoString(hora: Int, minutos: Int, segundos: Int, fraccion: Int) -> String{
        
        var TiempoString = ""
        TiempoString += String(format: "%02d", hora)
        TiempoString += " : "
        TiempoString += String(format: "%02d", minutos)
        TiempoString += " : "
        TiempoString += String(format: "%02d", segundos)
        TiempoString += " . "
        TiempoString += String(format: "%02d", fraccion)
        
        return TiempoString
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
