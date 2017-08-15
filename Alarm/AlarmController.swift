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
    
    func addAlarm(fireTimeFromMidnight: TimeInterval, title: String) -> Alarm {
        let alarm = Alarm(fireTimeFromMidnight: fireTimeFromMidnight, title: title)
        alarms.append(alarm)
        
        return alarm
    }
    
    func update(alarm: Alarm, fireTimeFromMidnight: TimeInterval, title: String) {
        alarm.fireTimeFromMidnight = fireTimeFromMidnight
        alarm.title = title
        
    }
    
    func delete(alarm: Alarm) {
        guard let index = alarms.index(of: alarm) else { return }
        alarms.remove(at: index)
    }
    
    func toggleEnabled(for alarm: Alarm) {
        alarm.enabled = !alarm.enabled
    }
    
    func saveToPersistentStorage() {
        
    }
}
