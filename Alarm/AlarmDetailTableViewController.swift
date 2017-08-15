//
//  AlarmDetailTableViewController.swift
//  Alarm
//
//  Created by Luis Puentes on 8/15/17.
//  Copyright © 2017 LuisPuentes. All rights reserved.
//

import UIKit

class AlarmDetailTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var alarmNameTextField: UITextField!
    @IBOutlet weak var enableButton: UIButton!
    
    @IBAction func enableButtonTapped(_ sender: Any) {
    }
    @IBAction func saveButtonTapped(_ sender: Any) {
    }
}
