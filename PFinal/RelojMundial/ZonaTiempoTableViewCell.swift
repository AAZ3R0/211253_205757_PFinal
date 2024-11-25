//
//  ZonaTiempoTableViewCell.swift
//  PFinal
//
//  Created by alumno on 11/22/24.
//

import UIKit
//Clase de tipo UITableViewCell donde se nos permitirá llevar a cabo funciones relacionadas con las celdas de de la pantalla
class ZonaTiempoTableViewCell: UITableViewCell {
    
    //Variable de etiqueta que es para definir el nombre del país
    @IBOutlet weak var TimeZoneName: UILabel!
    
    //Variable de etiqueta que es para definir la hora del país
    @IBOutlet weak var TimeLabel: UILabel!
    
    //Función de tipo override que es para inicializar el cell
    override func awakeFromNib() {
        super.awakeFromNib()
        //Intervalo de tiempo con selector
        let timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(setTime), userInfo: nil, repeats: true)
        //Para que el reloj de cada una de las celdas corra como si fuese un reloj normal
        RunLoop.current.add(timer, forMode: RunLoop.Mode.common)
    }
    
    //Función de tipo objeto que nos permitirá usar el selector para incluir el país con su zona horaria
    @objc func setTime(){
        //El texto del label que guarda la obtención de tiempo
        TimeLabel.text = getTime()
    }
    
    //Función para obtener el tiempo en formato cadena
    func getTime() -> String{
        //Variable de tipo cadena nula
        var timeString = ""
        
        //Condicional para realizar ciertas acciones si el texto del label TimeZoneName no es nulo
        if TimeZoneName.text != ""{
            //Variable constante que es para definir el formato de fecha
            let formatter = DateFormatter()
            //Definir el estilo de la constante de formatter (fecha)
            formatter.timeStyle = .long
            //Definir TimeZone como texto
            formatter.timeZone = TimeZone(identifier: TimeZoneName.text!)
            //Variable de tipo constante basada en la fecha
            let timeNow = Date()
            //Definir el formato de la variable timeString
            timeString = formatter.string(from: timeNow)
            
        }
        //Regresa la variable timeString
        return timeString
    }

    //Función override que configura la vista de la celda seleccionada
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
