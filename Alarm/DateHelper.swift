//
//  DateHelper.swift
//  Alarm
//
//  Created by Luis Puentes on 8/13/17.
//  Copyright © 2017 LuisPuentes. All rights reserved.
//

import Foundation

class DateHelper {
    static var thisMorningAtMidnight: Date? {
        let calendar = Calendar.current
        let now = Date()
        
        return calendar.date(bySettingHour: 0, minute: 0, second: 0, of: now)
    }
    
    static var tomorrowMorningAtMidnight: Date? {
        let calendar = Calendar.current
        guard let thisMorningAtMidnight = thisMorningAtMidnight else { return nil }
        
        return calendar.date(byAdding: .day, value: 1, to: thisMorningAtMidnight)
    }
}
