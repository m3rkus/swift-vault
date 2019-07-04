//
//  DateHelpers.swift
//  swift-vault
//
//  Created by m3rk on 02/12/2018.
//  Copyright © 2018 m3rk edge. All rights reserved.
//

import Foundation


// MARK: - Date data extractors
extension Date {
    
    func daySuffix() -> String {
        let calendar = Calendar.current
        let dayOfMonth = calendar.component(.day, from: self)
        switch dayOfMonth {
        case 1, 21, 31: return "st"
        case 2, 22: return "nd"
        case 3, 23: return "rd"
        default: return "th"
        }
    }
    
    func years(from date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
    }
    
    /// Returns the amount of months from another date
    func months(from date: Date) -> Int {
        return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
    }
    
    /// Returns the amount of weeks from another date
    func weeks(from date: Date) -> Int {
        return Calendar.current.dateComponents([.weekOfMonth], from: date, to: self).weekOfMonth ?? 0
    }
    
    /// Returns the amount of days from another date
    func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
    
    /// Returns the amount of hours from another date
    func hours(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }
    
    /// Returns the amount of minutes from another date
    func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
    
    /// Returns the amount of seconds from another date
    func seconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }
    
    /// Returns the a custom time interval description from another date
    func offset(from date: Date) -> String {
        if years(from: date)   > 0 {
            return "\(years(from: date)) year\(years(from: date) == 1 ? "" : "s") ago"
        }
        if months(from: date)  > 0 {
            return "\(months(from: date)) month\(months(from: date) == 1 ? "" : "s") ago"
        }
        if weeks(from: date)   > 0 {
            return "\(weeks(from: date)) week\(weeks(from: date) == 1 ? "" : "s") ago"
        }
        if days(from: date)    > 0 {
            return "\(days(from: date)) day\(days(from: date) == 1 ? "" : "s") ago"
        }
        if hours(from: date)   > 0 {
            return "\(hours(from: date)) hour\(hours(from: date) == 1 ? "" : "s") ago"
        }
        if minutes(from: date) > 0 {
            return "\(minutes(from: date)) min\(minutes(from: date) == 1 ? "" : "utes") ago"
        }
        if seconds(from: date) > 0 {
            return "\(seconds(from: date)) sec\(seconds(from: date) == 1 ? "" : "onds") ago"
        }
        return ""
    }
    
}

// MARK: - Date helpers
extension Date {
    
    func ordinalDay() -> String {
        
        let ordinalFormatter = NumberFormatter()
        ordinalFormatter.numberStyle = .ordinal
        let day = Calendar.current.component(.day, from: self)
        let dayOrdinal = ordinalFormatter.string(from: NSNumber(value: day))
        return dayOrdinal ?? ""
    }
    
    /// Return array of dates based of day number of date difference between two dates
    /// Example:
    /// stardDate - Jun 20
    /// endDate - Jun 23
    /// return - [Jun 20, Jun 21, Jun 22, Jun 23]
    static func getDayDatesRangeBetween(startDate: Date,
                                        endDate: Date) -> [Date] {
        
        let startDate = Calendar.current.startOfDay(for: startDate)
        let endDate = Calendar.current.startOfDay(for: endDate)
        
        guard let numberOfDaysBetweenDates = Calendar.current.dateComponents(
            [.day],
            from: startDate,
            to: endDate).day
            else {
                return []
        }
        guard numberOfDaysBetweenDates > 0 else { return [] }
        var dayDatesRange: [Date] = []
        for i in 0 ... numberOfDaysBetweenDates {
            dayDatesRange.append(startDate.addDays(i))
        }
        return dayDatesRange
    }
    
    var isBelongToLastMonth: Bool {
        let lastMonthDate = Date().addMonths(-1)
        guard
            let startOfLastMonth = lastMonthDate.startOfMonth,
            let endOfLastMonth = lastMonthDate.endOfMonth?.dateWithUpdatedTime(hours: 23, minutes: 59, seconds: 59)
            else {
                return false
        }
        return self >= startOfLastMonth && self <= endOfLastMonth
    }
    
    var isBelongToCurrentMonth: Bool {
        guard
            let startOfCurrentMonth = Date().startOfMonth,
            let endOfCurrentMonth = Date().endOfMonth?.dateWithUpdatedTime(hours: 23, minutes: 59, seconds: 59)
            else {
                return false
        }
        return self >= startOfCurrentMonth && self <= endOfCurrentMonth
    }
    
    var startOfMonth: Date? {
        return getFirstAndLastDayOfMonth().startOfMonth
    }
    
    var endOfMonth: Date? {
        return getFirstAndLastDayOfMonth().endOfMonth
    }
    
    fileprivate func getFirstAndLastDayOfMonth() -> (startOfMonth: Date?, endOfMonth: Date?) {
        
        let calendar = Calendar.current
        var startOfMonth: Date?
        var endOfMonth: Date?
        
        // start of month
        let startOfMonthComponents = calendar.dateComponents([.year, .month],
                                                             from: self)
        startOfMonth = calendar.date(from: startOfMonthComponents)
        
        // end of month
        var endOfMonthComponents = DateComponents()
        endOfMonthComponents.month = 1
        endOfMonthComponents.day = -1
        if let startOfMonth = startOfMonth {
            endOfMonth = calendar.date(byAdding: endOfMonthComponents, to: startOfMonth)
        }
        
        return (startOfMonth, endOfMonth)
    }
    
    func dateWithUpdatedTime(hours: Int, minutes: Int, seconds: Int) -> Date {
        guard let updatedDate = Calendar.current.date(
            bySettingHour: hours,
            minute: minutes,
            second: seconds,
            of: self)
        else {
            print("Unable to add time specs to date")
            return Date()
        }
        return updatedDate
    }

}


// MARK: - Date manipulation
extension Date {
    
    var firstDayOfWeek: Date {
        var beginningOfWeek = Date()
        var interval = TimeInterval()
        
        _ = Calendar.current.dateInterval(of: .weekOfYear, start: &beginningOfWeek, interval: &interval, for: self)
        return beginningOfWeek
    }
    
    func addWeeks(_ numWeeks: Int) -> Date {
        var components = DateComponents()
        components.weekOfYear = numWeeks
        
        return Calendar.current.date(byAdding: components, to: self)!
    }
    
    func weeksAgo(_ numWeeks: Int) -> Date {
        return addWeeks(-numWeeks)
    }
    
    func addDays(_ numDays: Int) -> Date {
        var components = DateComponents()
        components.day = numDays
        
        return Calendar.current.date(byAdding: components, to: self)!
    }
    
    func addMonths(_ amount: Int) -> Date {
        var components = DateComponents()
        components.month = amount
        
        return Calendar.current.date(byAdding: components, to: self)!
    }
    
    func addYears(_ amount: Int) -> Date {
        var components = DateComponents()
        components.year = amount
        
        return Calendar.current.date(byAdding: components, to: self)!
    }
    
    func daysAgo(_ numDays: Int) -> Date {
        return addDays(-numDays)
    }
    
    func addHours(_ numHours: Int) -> Date {
        var components = DateComponents()
        components.hour = numHours
        
        return Calendar.current.date(byAdding: components, to: self)!
    }
    
    func hoursAgo(_ numHours: Int) -> Date {
        return addHours(-numHours)
    }
    
    func addMinutes(_ numMinutes: Double) -> Date {
        return self.addingTimeInterval(60 * numMinutes)
    }
    
    func minutesAgo(_ numMinutes: Double) -> Date {
        return addMinutes(-numMinutes)
    }
    
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }
    
    var endOfDay: Date {
        let cal = Calendar.current
        var components = DateComponents()
        components.day = 1
        return cal.date(byAdding: components, to: self.startOfDay)!.addingTimeInterval(-1)
    }
    
    var zeroBasedDayOfWeek: Int? {
        let comp = Calendar.current.component(.weekday, from: self)
        return comp - 1
    }
    
    func hoursFrom(_ date: Date) -> Double {
        return Double(Calendar.current.dateComponents([.hour], from: date, to: self).hour!)
    }
    
    func daysBetween(_ date: Date) -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: self.startOfDay, to: date.startOfDay)
        
        return components.day!
    }
    
    var percentageOfDay: Double {
        let totalSeconds = self.endOfDay.timeIntervalSince(self.startOfDay) + 1
        let seconds = self.timeIntervalSince(self.startOfDay)
        let percentage = seconds / totalSeconds
        return max(min(percentage, 1.0), 0.0)
    }
    
    var numberOfWeeksInMonth: Int {
        let calendar = Calendar.current
        let weekRange = (calendar as NSCalendar).range(of: NSCalendar.Unit.weekOfYear, in: NSCalendar.Unit.month, for: self)
        
        return weekRange.length
    }
    
}
