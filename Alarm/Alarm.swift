//
//  Alarm.swift
//  Alarm
//
//  Created by Luis Puentes on 8/13/17.
//  Copyright © 2017 LuisPuentes. All rights reserved.
//

import Foundation

class Alarm: Equatable {
    
    var fireTimeFromMidnight: TimeInterval
    var title: String
    var enabled: Bool
    let uuid: String
    
    init(fireTimeFromMidnight: TimeInterval, title: String, enabled: Bool = true, uuid: String = UUID().uuidString) {
        
        self.fireTimeFromMidnight = fireTimeFromMidnight
        self.title = title
        self.enabled = enabled
        self.uuid = uuid
    }
    
    var fireDate: Date? {
        guard let thisMorningAtMidnight = DateHelper.thisMorningAtMidnight else { return nil }
        let fireTimeInMinutes = Int(fireTimeFromMidnight/60)
        let fireTimeInSeconds = TimeInterval(fireTimeInMinutes * 60)
        let fireDateFromThisMorning = Date(timeInterval: fireTimeInSeconds, since: thisMorningAtMidnight)
        
        return fireDateFromThisMorning
    }
    
    var fireTimeAsString: String {
        let fireTimeFromMidnight = Int(self.fireTimeFromMidnight)
        var hours = fireTimeFromMidnight/60/60
        let minutes = (fireTimeFromMidnight - (hours*60*60)) / 60
        
        if hours >= 13 {
            return String(format: "%2d:%02d PM", [hours - 12, minutes])
        } else if hours >= 12 {
            return String(format: "%2d:%02d PM", [hours , minutes])
        } else {
            if hours == 0 {
                hours = 12
            }
            return String(format: "%2d:%02d AM", [hours, minutes])
        }
    }
}

    func ==(lhs: Alarm, rhs: Alarm) -> Bool {
        return lhs.uuid == rhs.uuid
}
