//
//  AlarmDetailTableViewController.swift
//  Alarm
//
//  Created by Luis Puentes on 8/15/17.
//  Copyright © 2017 LuisPuentes. All rights reserved.
//

import UIKit

class AlarmDetailTableViewController: UITableViewController, AlarmScheduler {

    var alarm: Alarm? {
        didSet {
            if isViewLoaded {
                updateViews()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    func updateViews() {
        guard let alarm = alarm,
            let thisMorningAtMidnight = DateHelper.thisMorningAtMidnight,
        isViewLoaded else {
            enableButton.isHidden = true
            return }
        datePicker.setDate(Date(timeInterval: alarm.fireTimeFromMidnight, since: thisMorningAtMidnight), animated: false)
        alarmNameTextField.text = alarm.title
        
        enableButton.isHidden = false
        
        if alarm.enabled {
            enableButton.setTitle("Disable", for: UIControlState())
            enableButton.setTitleColor(.white, for: UIControlState())
            enableButton.backgroundColor = .red
        } else {
            enableButton.setTitle("Enable", for: UIControlState())
            enableButton.setTitleColor(.blue, for: UIControlState())
            enableButton.backgroundColor = .gray
        }
        self.title = alarm.title
    }
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var alarmNameTextField: UITextField!
    @IBOutlet weak var enableButton: UIButton!
    
    @IBAction func enableButtonTapped(_ sender: Any) {
        guard let alarm = alarm else { return }
        AlarmController.shared.toggleEnabled(for: alarm)
        if alarm.enabled {
            scheduleUserNotifications(for: alarm)
        } else {
            cancelUserNotifications(for: alarm)
        }
        updateViews()
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let title = alarmNameTextField.text,
            let thisMorningAtMidnight = DateHelper.thisMorningAtMidnight else { return }
        let timeIntervalSinceMidnight = datePicker.date.timeIntervalSince(thisMorningAtMidnight)
        
        if let alarm = alarm {
            AlarmController.shared.update(alarm: alarm, fireTimeFromMidnight: timeIntervalSinceMidnight, title: title)
            cancelUserNotifications(for: alarm)
            scheduleUserNotifications(for: alarm)
        } else {
            let alarm = AlarmController.shared.addAlarm(fireTimeFromMidnight: timeIntervalSinceMidnight, title: title)
            self.alarm = alarm
            scheduleUserNotifications(for: alarm)
        }
        navigationController?.popViewController(animated: true)
    }
}
