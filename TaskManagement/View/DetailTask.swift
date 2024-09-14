//
//  DetailTask.swift
//  TaskManagement
//
//  Created by xqsadness on 14/9/24.
//

import SwiftUI

struct DetailTask: View {
    
    var task: Task
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Detail task")
                .ubuntu(20, weight: .medium)
                .hAlign(.center)
                .padding(.bottom, 4)
            
            taskDetailRow(label: "Task name:", value: task.taskName, color: task.taskCategory.color)
            
            taskDetailRow(label: "Task description:", value: task.taskDescription, color: task.taskCategory.color)
            
            taskDetailRow(label: "Time:", value: task.dateAdded.toString("yyyy-MM-dd HH:mm:ss"), color: task.taskCategory.color)
            
            taskDetailRow(label: "Category:", value: task.taskCategory.rawValue.capitalized, color: task.taskCategory.color)
            
            taskDetailRow(label: "Completed:", value: task.isCompleted ? "Yes" : "No", color: task.taskCategory.color)
            
        }
        .hAlign(.center)
        .vAlign(.top)
        .padding(9)
        .frame(height: 230)
        .background(.white)
        .foregroundStyle(task.taskCategory.color)
        .clipShape(.rect(cornerRadius: 30))
        .padding(.horizontal, 15)
        .presentationDetents([.height(230)])
        .presentationBackground(.clear)
    }
    
    @ViewBuilder
    func taskDetailRow(label: String, value: String, color: Color) -> some View {
        HStack {
            Text(label)
                .foregroundColor(.black)
            Text(value.isEmpty ? "No" : value)
                .foregroundStyle(color)
        }
        .ubuntu(16, weight: .regular)
    }
}
