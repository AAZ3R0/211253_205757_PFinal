//
//  ZonaTiempoTableViewCell.swift
//  PFinal
//
//  Created by alumno on 11/22/24.
//

import UIKit

class ZonaTiempoTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var TimeZoneName: UILabel!
    
    
    @IBOutlet weak var TimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(setTime), userInfo: nil, repeats: true)
        
        RunLoop.current.add(timer, forMode: RunLoop.Mode.common)
    }
    
    @objc func setTime(){
        TimeLabel.text = getTime()
    }
    
    func getTime() -> String{
        var timeString = ""
        
        if TimeZoneName.text != ""{
            
            let formatter = DateFormatter()
            formatter.timeStyle = .long
            formatter.timeZone = TimeZone(identifier: TimeZoneName.text!)
            
            let timeNow = Date()
            timeString = formatter.string(from: timeNow)
            
        }
        
        return timeString
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
