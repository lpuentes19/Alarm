//
//  AlarmController.swift
//  Alarm
//
//  Created by Luis Puentes on 8/14/17.
//  Copyright © 2017 LuisPuentes. All rights reserved.
//

import Foundation
import UserNotifications

class AlarmController {
    
    static let shared = AlarmController()
    
    // MARK: Properties
    var alarms: [Alarm] = []
    
    init() {
        loadFromPersistentStorage()
    }
    // Add Alarm
    func addAlarm(fireTimeFromMidnight: TimeInterval, title: String) -> Alarm {
        let alarm = Alarm(fireTimeFromMidnight: fireTimeFromMidnight, title: title)
        alarms.append(alarm)
        saveToPersistentStorage()
        
        return alarm
    }
    // Update
    func update(alarm: Alarm, fireTimeFromMidnight: TimeInterval, title: String) {
        alarm.fireTimeFromMidnight = fireTimeFromMidnight
        alarm.title = title
        saveToPersistentStorage()
    }
    // Delete
    func delete(alarm: Alarm) {
        guard let index = alarms.index(of: alarm) else { return }
        alarms.remove(at: index)
        saveToPersistentStorage()
    }
    // Toggle
    func toggleEnabled(for alarm: Alarm) {
        alarm.enabled = !alarm.enabled
        saveToPersistentStorage()
    }
    // Save
    func saveToPersistentStorage() {
        guard let filePath = type(of: self).persistentAlarmsFilePath else { return }
        NSKeyedArchiver.archiveRootObject(self.alarms, toFile: filePath)
    }
    // Load
    func loadFromPersistentStorage() {
        guard let filePath = type(of: self).persistentAlarmsFilePath else { return }
        guard let alarms = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? [Alarm] else { return }
        self.alarms = alarms
    }
    
    static private var persistentAlarmsFilePath: String? {
        let directories = NSSearchPathForDirectoriesInDomains(.documentDirectory, .allDomainsMask, true)
        guard let documentsDirectory = directories.first as NSString? else { return nil }
        return documentsDirectory.appendingPathComponent("Alarms.plist")
    }
}

protocol AlarmScheduler {
    func scheduleUserNotifications(for alarm: Alarm)
    func cancelUserNotifications(for alarm: Alarm)
}

extension AlarmScheduler {
    
    func scheduleUserNotifications(for alarm: Alarm) {
        
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "Time's up!"
        notificationContent.body = "Your alarm \(alarm.title) is done"
        notificationContent.sound = UNNotificationSound.default()
        
        guard let fireDate = alarm.fireDate else { return }
        let triggerDate = Calendar.current.dateComponents([.hour, .minute, .second], from: fireDate)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: true)
        
        let request = UNNotificationRequest(identifier: alarm.uuid, content: notificationContent, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("Unable to add notification request, \(error.localizedDescription)")
            }
        }
    }
    
    func cancelUserNotifications(for alarm: Alarm) {
        
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [alarm.uuid])
    }
}


