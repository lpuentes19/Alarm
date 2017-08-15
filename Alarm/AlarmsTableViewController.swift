//
//  AlarmsTableViewController.swift
//  Alarm
//
//  Created by Luis Puentes on 8/15/17.
//  Copyright © 2017 LuisPuentes. All rights reserved.
//

import UIKit

class AlarmsTableViewController: UITableViewController, SwitchTableViewCellDelegate, AlarmScheduler {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AlarmController.shared.alarms.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "alarmCell", for: indexPath) as? SwitchTableViewCell else { return UITableViewCell() }
        
        cell.alarm = AlarmController.shared.alarms[indexPath.row]
        cell.delegate = self
        
        return cell
    }
    
    // Delete Rows
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alarm = AlarmController.shared.alarms[indexPath.row]
            AlarmController.shared.delete(alarm: alarm)
            cancelUserNotifications(for: alarm)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    // SwitchValueChangedDelegate Protocol Method
    func switchCellSwitchValueChanged(cell: SwitchTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let alarm = AlarmController.shared.alarms[indexPath.row]
        AlarmController.shared.toggleEnabled(for: alarm)
        
        if alarm.enabled {
            scheduleUserNotifications(for: alarm)
        } else {
            cancelUserNotifications(for: alarm)
        }
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAlarmDetailVC" {
            guard let detailVC = segue.destination as? AlarmDetailTableViewController,
                let indexPath = tableView.indexPathForSelectedRow else { return }
            detailVC.alarm = AlarmController.shared.alarms[indexPath.row]
        }
    }
}
