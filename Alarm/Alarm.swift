//
//  Alarm.swift
//  Alarm
//
//  Created by Luis Puentes on 8/13/17.
//  Copyright © 2017 LuisPuentes. All rights reserved.
//

import Foundation

class Alarm: NSObject, NSCoding {
    
    private let fireTimeFromMidnightKey = "fireTimeFromMidnight"
    private let titleKey = "title"
    private let enabledKey = "enabled"
    private let UUIDKey = "UUID"
    
    // MARK: Properties
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
    // MARK: NSObject Methods
    required init?(coder aDecoder: NSCoder) {
        
        guard let title = aDecoder.decodeObject(forKey: titleKey) as? String,
            let uuid = aDecoder.decodeObject(forKey: UUIDKey) as? String else { return nil }
        
        self.fireTimeFromMidnight = TimeInterval(aDecoder.decodeDouble(forKey: fireTimeFromMidnightKey))
        self.title = title
        self.enabled = aDecoder.decodeBool(forKey: enabledKey)
        self.uuid = uuid
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(fireTimeFromMidnight, forKey: fireTimeFromMidnightKey)
        aCoder.encode(title, forKey: titleKey)
        aCoder.encode(enabled, forKey: enabledKey)
        aCoder.encode(uuid, forKey: UUIDKey)
    }
}
    // MARK: Equatable
    func ==(lhs: Alarm, rhs: Alarm) -> Bool {
        return lhs.uuid == rhs.uuid
}
