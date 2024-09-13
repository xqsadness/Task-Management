//
//  Task.swift
//  TaskManagement
//
//  Created by xqsadness on 30/07/2024.
//

import SwiftUI
import SwiftData

// MARK: Task Model
@Model
class Task {
    @Attribute(.unique) var id: UUID
    var dateAdded: Date
    var taskName: String
    var taskDescription: String
    var taskCategory: Category

    init(dateAdded: Date, taskName: String, taskDescription: String, taskCategory: Category) {
        self.id = UUID()
        self.dateAdded = dateAdded
        self.taskName = taskName
        self.taskDescription = taskDescription
        self.taskCategory = taskCategory
    }
}
