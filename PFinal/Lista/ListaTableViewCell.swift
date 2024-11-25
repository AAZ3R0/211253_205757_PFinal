//
//  ListaTableViewCell.swift
//  PFinal
//
//  Created by alumno on 11/25/24.
//

import UIKit

class ListaTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var Nombre: UILabel!
    
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
