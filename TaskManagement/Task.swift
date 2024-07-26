//
//  Task.swift
//  TaskManagement
//
//  Created by xqsadness on 26/07/2024.
//

import SwiftUI

struct Task: Identifiable{
    var id: UUID = .init()
    var title: String
    var caption: String
    var date: Date = .init()
    var isCompleted = false
    var tint: Color
}

// sample task
var sampleTask: [Task] = [
    .init(title: "Standup", caption: "Every day meeting",date: Date.now ,tint: .yellow),
    .init(title: "Kickoff", caption: "Travel app",date: Date.now ,tint: .gray),
    .init(title: "UI Design", caption: "Fintech app",date: Date.now ,tint: .green),
    .init(title: "Logo Design", caption: "Test app",date: Date.now ,tint: .purple)
]

//Date ex
extension Date{
    static func updateHour(_ value: Int) -> Date{
        let calendar = Calendar.current
        return calendar.date(byAdding: .hour, value: value, to: .init()) ?? .init()
    }
}
