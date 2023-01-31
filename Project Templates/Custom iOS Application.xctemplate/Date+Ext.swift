//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ All rights reserved.
//

import Foundation

extension Date {
    func toString(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale(identifier: "ko")
        formatter.timeZone = TimeZone.current
        return formatter.string(from: self)
    }
    
    static func make(year: Int, month: Int, day: Int = 1, hour: Int = 0, minute: Int = 0, seconds: Int = 0) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-M-d H:m:s"
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        return formatter.date(from: "\(year)-\(month)-\(day) \(hour):\(minute):\(seconds)")
    }
    
    func fullDistance(from date: Date, resultIn component: Calendar.Component, calendar: Calendar = .current) -> Int? {
        calendar.dateComponents([component], from: self, to: date).value(for: component)
    }
    
    func fullDistanceWithoutTime(from date: Date, resultIn component: Calendar.Component, calendar: Calendar = .current) -> Int? {
        guard let selfDate = calendar.date(from: calendar.dateComponents([.year, .month, .day], from: self)), let compareDate = calendar.date(from: calendar.dateComponents([.year, .month, .day], from: date)) else {
            return 0
        }
        
        return calendar.dateComponents([component], from: selfDate, to: compareDate).value(for: component)
    }
    
    var year: Int {
        return Calendar.current.component(.year, from: self)
    }
    
    var month: Int {
        return Calendar.current.component(.month, from: self)
    }
    
    var day: Int {
        return Calendar.current.component(.day, from: self)
    }
    
    var weekday: Int {
        return Calendar.current.component(.weekday, from: self)
    }
}

