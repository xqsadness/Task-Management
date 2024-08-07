//
//  Task.swift
//  TaskManagement
//
//  Created by darktech4 on 30/07/2024.
//

import SwiftUI

// MARK: Task Model
struct Task: Identifiable{
    var id: UUID = .init()
    var dateAdded: Date
    var taskName: String
    var taskDescription: String
    var taskCategory: Category
}

/// - Sample Tasks
let now = Date().timeIntervalSince1970
var sampleTasks: [Task] = [
    .init(dateAdded: Date (timeIntervalSince1970: now), taskName: "Edit YT Video", taskDescription: "", taskCategory:
            .general)
]
