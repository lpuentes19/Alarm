//
//  SwitchTableViewCell.swift
//  Alarm
//
//  Created by Luis Puentes on 8/15/17.
//  Copyright © 2017 LuisPuentes. All rights reserved.
//

import UIKit

class SwitchTableViewCell: UITableViewCell {

    weak var delegate: SwitchTableViewCellDelegate?
    
    var alarm: Alarm? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        guard let alarm = alarm else { return }
        timeLabel.text = alarm.fireTimeAsString
        alarmNameLabel.text = alarm.title
        alarmSwitch.isOn = alarm.enabled
    }
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var alarmNameLabel: UILabel!
    @IBOutlet weak var alarmSwitch: UISwitch!
    
    @IBAction func switchValueChanged(_ sender: Any) {
        delegate?.switchCellSwitchValueChanged(cell: self)
    }
}

protocol SwitchTableViewCellDelegate: class {
    func switchCellSwitchValueChanged(cell: SwitchTableViewCell)
}
