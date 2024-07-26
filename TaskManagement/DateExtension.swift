//
//  DateExtension.swift
//  TaskManagement
//
//  Created by xqsadness on 26/07/2024.
//

import Foundation

extension Date{
    
    func format(_ format: String = "yyyy-MM-dd") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    //checking whether the date is today
    var isToday: Bool{
        return Calendar.current.isDateInToday(self)
    }

    //Fetching week based on given date
    func fetchWeek(_ date: Date = .init()) -> [WeekDay]{
        let calendar = Calendar.current
        let startDate = calendar.startOfDay(for: date)
        
        var week: [WeekDay] = []
        let weekDate = calendar.dateInterval(of: .weekOfMonth, for: startDate)
        guard (weekDate?.start) != nil else{
            return []
        }
        
        //Iterating to get the full week
        (0..<7).forEach { index in
            if let weekDay = calendar.date(byAdding: .day, value: index, to: startDate){
                week.append(.init(date: weekDay))
            }
        }
        
        return week
    }
    
    //Creating next week, based on the last current week date
    func createNextWeek() -> [WeekDay]{
        let calendar = Calendar.current
        let startOfLastDate = calendar.startOfDay(for: self)
        guard let nextDate = calendar.date(byAdding: .day, value: 1, to: startOfLastDate) else{
            return []
        }
        
        return fetchWeek(nextDate)
    }
    
    //Creating previos week, based on the last current week date
    func createPreviosWeek() -> [WeekDay]{
        let calendar = Calendar.current
        let startOfLastDate = calendar.startOfDay(for: self)
        guard let nextDate = calendar.date(byAdding: .day, value: -1, to: startOfLastDate) else{
            return []
        }
        
        return fetchWeek(nextDate)
    }
    
    struct WeekDay: Identifiable{
        var id: UUID = .init()
        var date: Date
    }
}


