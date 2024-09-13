//
//  TaskManagementApp.swift
//  TaskManagement
//
//  Created by xqsadness on 26/07/2024.
//

import SwiftUI

@main
struct TaskManagementApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Task.self)
        }
    }
}
