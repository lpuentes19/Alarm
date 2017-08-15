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
    
    var alarms: [Alarm] = []
    
    init() {
        loadFromPersistentStorage()
    }
    
    func addAlarm(fireTimeFromMidnight: TimeInterval, title: String) -> Alarm {
        let alarm = Alarm(fireTimeFromMidnight: fireTimeFromMidnight, title: title)
        alarms.append(alarm)
        saveToPersistentStorage()
        
        return alarm
    }
    
    func update(alarm: Alarm, fireTimeFromMidnight: TimeInterval, title: String) {
        alarm.fireTimeFromMidnight = fireTimeFromMidnight
        alarm.title = title
        saveToPersistentStorage()
    }
    
    func delete(alarm: Alarm) {
        guard let index = alarms.index(of: alarm) else { return }
        alarms.remove(at: index)
        saveToPersistentStorage()
    }
    
    func toggleEnabled(for alarm: Alarm) {
        alarm.enabled = !alarm.enabled
        saveToPersistentStorage()
    }
    
    func saveToPersistentStorage() {
        guard let filePath = type(of: self).persistentAlarmsFilePath else { return }
        NSKeyedArchiver.archiveRootObject(self.alarms, toFile: filePath)
    }
    
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
