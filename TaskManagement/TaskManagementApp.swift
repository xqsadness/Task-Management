//
//  TaskManagementApp.swift
//  TaskManagement
//
//  Created by xqsadness on 26/07/2024.
//

import SwiftUI

@main
struct TaskManagementApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Task.self)
        }
    }
}
