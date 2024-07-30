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
            .general),
    .init(dateAdded: Date(timeIntervalSince1970: now + 1238123), taskName: "Matched Geometry Effect (Issue)", taskDescription:
            "", taskCategory: .bug),
    .init(dateAdded: Date(timeIntervalSince1970: now + 2000), taskName: "Multi-ScrollView", taskDescription: "",
          taskCategory: .challenge),
    .init(dateAdded: Date(timeIntervalSince1970: now + 9929), taskName: "Loreal Ipsum", taskDescription: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s.", taskCategory: .idea),
    .init(dateAdded: Date (timeIntervalSince1970: now + 213123), taskName: "Complete UI Animation Challenge", taskDescription:
            "", taskCategory: .challenge),
    .init(dateAdded: Date (timeIntervalSince1970: now + 123123), taskName: "Fix Shadow issue on Mockup's", taskDescription: "",
          taskCategory: .bug),
    .init(dateAdded: Date(timeIntervalSince1970: now + 888), taskName: "Add Shadow Effect in Mockview App",
          taskDescription: "", taskCategory: .idea),
    .init(dateAdded: Date(timeIntervalSince1970: now + 12322), taskName: "Twitter/Instagram Post", taskDescription: "",
          taskCategory: .general),
    .init(dateAdded: Date (timeIntervalSince1970: now + 19), taskName: "Lorem Ipsum", taskDescription: "", taskCategory:
            .modifiers),
]
