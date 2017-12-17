//
//  AddAlarmTableViewCell.swift
//  World Clock
//
//  Created by dinesh danda on 9/7/16.
//  Copyright © 2016 dinesh danda. All rights reserved.
//

import UIKit

protocol UpdateSwitchValueProtocol {
    func updateAlarmSwitch(at: Int, value: Bool)
}

class AddAlarmTableViewCell: UITableViewCell {

    
    @IBOutlet var alarmLabel: UILabel!
    @IBOutlet var alarmSwitch: UISwitch!
    
    var delegate: UpdateSwitchValueProtocol?
    
    var cellIndex: Int!
    
    @IBAction func switchValueChanged(_ sender: UISwitch) {
        
        delegate?.updateAlarmSwitch(at: cellIndex, value: sender.isOn)
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
