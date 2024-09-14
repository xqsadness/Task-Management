//
//  NotificationService.swift
//  TaskManagement
//
//  Created by xqsadness on 14/9/24.
//

import SwiftUI
import UserNotifications

/// NotificationService: A service to manage local notifications for task reminders.
class NotificationService {
    
    // Singleton instance for global access
    static let shared = NotificationService()
    
    private init() {}
    
    /// Request notification permission from the user.
    /// This method should be called when the app is first launched.
    func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("Notification permission granted")
            } else {
                print("Notification permission denied: \(String(describing: error))")
            }
        }
    }
    
    /// Schedule a local notification for a given task.
    /// - Parameter task: The task for which the notification will be scheduled.
    func scheduleNotification(for task: Task) {
        let content = UNMutableNotificationContent()
        content.title = "Task Reminder"
        content.body = "It's time to complete your task: \(task.taskName)"
        content.sound = .default

        // Create trigger based on the task's dateAdded property
        let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: task.dateAdded)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)

        // Create a unique identifier for each task using the task's UUID
        let request = UNNotificationRequest(identifier: task.id.uuidString, content: content, trigger: trigger)

        // Add the request to the notification center
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Failed to schedule notification: \(error)")
            } else {
                print("Notification scheduled for task: \(task.taskName) at \(task.dateAdded)")
            }
        }
    }

    /// Cancel the notification for a given task.
    /// - Parameter task: The task for which the notification will be canceled.
    func cancelNotification(for task: Task) {
        // Remove the notification using the task's unique identifier (UUID)
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [task.id.uuidString])
        print("Notification canceled for task: \(task.taskName)")
    }

    /// Cancel all notifications.
    /// This will remove all pending notifications from the notification center.
    func cancelAllNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        print("All notifications have been canceled.")
    }
}
