//
//  Home.swift
//  TaskManagement
//
//  Created by xqsadness on 30/07/2024.
//

import SwiftUI

struct Home: View {
    
    //view props
    @State private var currentDay: Date = .init()
    @State private var tasks: [Task] = sampleTasks
    @State private var addNewTask: Bool = false
    
    var body: some View {
        ScrollView{
            TimelineView()
                .padding([.horizontal, .bottom], 15)
        }
        .scrollIndicators(.hidden)
        .safeAreaInset(edge: .top, spacing: 0) {
            HeaderWeekSlider(currentDate: $currentDay, addNewTask: $addNewTask)
            //            HeaderView()
        }
        .fullScreenCover(isPresented: $addNewTask){
            AddTaskView { task in
                tasks.append(task)
            }
        }
    }
    
    //Timeline view
    @ViewBuilder
    func TimelineView() -> some View{
        ScrollViewReader{ proxy in
            let hours = Calendar.current.hour
            let midHour = hours[hours.count / 2]
            VStack{
                let hours = Calendar.current.hour
                
                ForEach(hours, id: \.self){ hour in
                    TimelineViewRow(hour)
                        .id(hour)
                }
            }
            .onAppear{
                proxy.scrollTo(midHour)
            }
        }
    }
    //Timeline view row
    @ViewBuilder
    func TimelineViewRow(_ date: Date) -> some View{
        HStack(alignment: .top){
            Text(date.toString("h a"))
                .ubuntu(14, weight: .regular)
                .frame(width: 45, alignment: .leading)
            
            //Filtering tasks
            let calendar = Calendar.current
            let filteredTasks = tasks.filter{
                if let hour = calendar.dateComponents([.hour], from: date).hour,
                   let taskHour = calendar.dateComponents([.hour], from: $0.dateAdded).hour,
                   hour == taskHour && calendar.isDate($0.dateAdded, inSameDayAs: currentDay){
                    return true
                }
                return false
            }
            
            if filteredTasks.isEmpty{
                Rectangle()
                    .stroke(.gray.opacity(0.5), style: StrokeStyle(lineWidth: 0.5, lineCap: .butt, lineJoin: .bevel, dash: [5], dashPhase: 5))
                    .frame(height: 0.5)
                    .offset(y: 10)
            }else{
                //Task view
                VStack(spacing: 10){
                    ForEach(filteredTasks){ task in
                        TaskRow(task)
                    }
                }
            }
        }
        .hAlign(.leading)
        .padding(.vertical, 15)
    }
    
    //Task row
    @ViewBuilder
    func TaskRow(_ task: Task) -> some View{
        VStack(alignment: .leading, spacing: 8){
            Text(task.taskName.uppercased())
                .ubuntu(16, weight: .regular)
                .foregroundStyle(task.taskCategory.color)
            
            if !task.taskDescription.isEmpty{
                Text(task.taskDescription)
                    .ubuntu(14, weight: .light)
                    .foregroundStyle(task.taskCategory.color.opacity(0.8))
            }
        }
        .hAlign(.leading)
        .padding(12)
        .background{
            ZStack(alignment: .leading){
                Rectangle()
                    .fill(task.taskCategory.color)
                    .frame(width: 4)
                
                Rectangle()
                    .fill(task.taskCategory.color.opacity(0.25))
            }
        }
    }
}

#Preview {
    Home()
}
