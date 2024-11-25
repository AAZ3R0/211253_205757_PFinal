//
//  File.swift
//  PFinal
//
//  Created by alumno on 11/25/24.
//

import UIKit

//Una estructura llamada Pais de tipo Codable para convertir los archivos JSON a Swift y viceversa
struct Pais: Codable{
    
    //Datos de la api que nos interesa acceder
    var name: Name
    var flag: String
}


//Otra estructura para acceder más a fondo en el dato name, especificando el tipo de nombre que contiene dentro.
struct Name: Codable{
    
    var common: String
}

