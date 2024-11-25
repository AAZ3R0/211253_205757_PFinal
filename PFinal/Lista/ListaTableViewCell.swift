//
//  ListaTableViewCell.swift
//  PFinal
//
//  Created by alumno on 11/25/24.
//

import UIKit

class ListaTableViewCell: UITableViewCell {
    
    //Label de la vista referenciado como Nombre
    @IBOutlet weak var Nombre: UILabel!
    //Label de la vista referenciado como Bandera
    @IBOutlet weak var Bandera: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
