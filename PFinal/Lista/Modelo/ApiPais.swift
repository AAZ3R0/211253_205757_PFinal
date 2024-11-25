//
//  ApiPais.swift
//  PFinal
//
//  Created by alumno on 11/25/24.
//

import Foundation
import UIKit

class ApiPais{
    
    let url_api = "https://jsonplaceholder.typicode.com/posts"
    var paises: [Pais] = []
    
    
    static var autoreferencia = ApiPais()
    
    private init(){}
        func obtener_lista(al_recibir: @escaping ([Pais]) -> Void){
            let ubicacion = URL(string: url_api)!
            URLSession.shared.dataTask(with: ubicacion) {
                (datos, respuesta, error) in do{
                    if let lista_recibida = datos{
                        let interpretacion_datos = try JSONDecoder().decode([Pais].self, from: lista_recibida)
                        
                        self.paises = interpretacion_datos
                        al_recibir(interpretacion_datos)
                        print(interpretacion_datos)
                    }else{
                        print(respuesta!)
                    }
                }catch{
                    print("Error")
                }
            }.resume()
        }
    }
