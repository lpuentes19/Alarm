//
//  Alarm.swift
//  Alarm
//
//  Created by Luis Puentes on 8/13/17.
//  Copyright © 2017 LuisPuentes. All rights reserved.
//

import Foundation

class Alarm {
    
    let fireTimeFromMidnight: TimeInterval
    let title: String
    let enabled: Bool
    let uuid: String
    
    init(fireTimeFromMidnight: TimeInterval, title: String, enabled: Bool, uuid: String) {
        
        self.fireTimeFromMidnight = fireTimeFromMidnight
        self.title = title
        self.enabled = enabled
        self.uuid = uuid
    }
    
    
}
