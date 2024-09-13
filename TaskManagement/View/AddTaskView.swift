//
//  AddTaskView.swift
//  TaskManagement
//
//  Created by xqsadness on 30/07/2024.
//

import SwiftUI

struct AddTaskView: View {
    
    //view props
    @Environment(\.dismiss) private var dismiss
    @State private var taskName: String = ""
    @State private var taskDesc: String = ""
    @State private var taskDate: Date = .init()
    @State private var taskCategory: Category = .general
    //Category animation props
    @State private var animateColor: Color = Category.general.color
    @State private var animate: Bool = false
    @Environment(\.modelContext) private var context
    
    var body: some View {
        VStack(alignment: .leading){
            VStack(alignment: .leading, spacing: 10){
                Button{
                    dismiss()
                }label: {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(.white)
                        .contentShape(.rect)
                }
                
                Text("Create New Task")
                    .ubuntu(28, weight: .light)
                    .foregroundStyle(.white)
                    .padding(.vertical, 15)
                
                TitleView("NAME")
                
                TextField("Your title", text: $taskName)
                    .ubuntu(16, weight: .regular)
                    .tint(.white)
                    .padding(.top, 2)
                
                Rectangle()
                    .fill(.white.opacity(0.7))
                    .frame(height: 1)
                
                TitleView("DATE")
                    .padding(.top, 15)
                
                HStack(alignment: .bottom, spacing: 12){
                    HStack(spacing: 12){
                        Text(taskDate.toString("EEEE dd, MMM"))
                            .ubuntu(16, weight: .regular)
                        
                        //Custom date picker
                        Image(systemName: "calendar")
                            .font(.title3)
                            .foregroundStyle(.white)
                            .overlay {
                                DatePicker("", selection: $taskDate, displayedComponents: [.date])
                                    .blendMode(.destinationOver)
                            }
                    }
                    .offset(y: -5)
                    .overlay(alignment: .bottom){
                        Rectangle()
                            .fill(.white.opacity(0.7))
                            .frame(height: 1)
                            .offset(y: 5)
                    }
                    
                    HStack(spacing: 12){
                        Text(taskDate.toString("hh:mm a"))
                            .ubuntu(16, weight: .regular)
                        
                        //Custom date picker
                        Image(systemName: "clock")
                            .font(.title3)
                            .foregroundStyle(.white)
                            .overlay {
                                DatePicker("", selection: $taskDate, displayedComponents: [.hourAndMinute])
                                    .blendMode(.destinationOver)
                            }
                    }
                    .offset(y: -5)
                    .overlay(alignment: .bottom){
                        Rectangle()
                            .fill(.white.opacity(0.7))
                            .frame(height: 1)
                            .offset(y: 5)
                    }
                }
                .padding(.bottom, 15)
            }
            .environment(\.colorScheme, .dark)
            .hAlign(.leading)
            .padding(15)
            .background{
                ZStack{
                    taskCategory.color
                    
                    GeometryReader{
                        let size = $0.size
                        
                        Rectangle()
                            .fill(animateColor)
                            .mask {
                                Circle()
                            }
                            .frame(width: animate ? size.width * 2 : 0, height: animate ? size.height * 2 : 0)
                            .offset(animate ? CGSize(width: -size.width / 2, height: -size.height / 2) : size)
                    }
                    .clipped()
                }
                .ignoresSafeArea()
            }
            
            VStack(alignment: .leading, spacing: 10){
                TitleView("DESCIPTION", .gray)
                
                TextField("About Your Task", text: $taskDesc)
                    .ubuntu(16, weight: .regular)
                    .padding(.top, 2)
                
                Rectangle()
                    .fill(.black.opacity(0.2))
                    .frame(height: 1)
                
                TitleView("CATEGORY", .gray)
                
                LazyVGrid(columns: Array(repeating: .init(.flexible(), spacing: 20), count: 3), spacing: 15) {
                    ForEach(Category.allCases, id: \.rawValue){ category in
                        Text(category.rawValue.uppercased())
                            .ubuntu(12, weight: .regular)
                            .hAlign(.center)
                            .padding(.vertical, 5)
                            .background{
                                RoundedRectangle(cornerRadius: 5, style: .continuous)
                                    .fill(category.color.opacity(0.3))
                            }
                            .foregroundStyle(category.color)
                            .contentShape(.rect)
                            .onTapGesture {
                                guard !animate else { return }
                                
                                animateColor = category.color
                                withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 1, blendDuration: 1)){
                                    animate = true
                                }
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                                    animate = false
                                    taskCategory = category
                                }
                            }
                    }
                }
                .padding(.top, 5)
                
                Button{
                    //Create task and pass it to the callback
                    let task = Task(dateAdded: taskDate, taskName: taskName, taskDescription: taskDesc, taskCategory: taskCategory)
                    context.insert(task)
                    dismiss()
                }label:{
                    Text("Create task")
                        .ubuntu(16, weight: .regular)
                        .foregroundStyle(.white)
                        .padding(.vertical, 15)
                        .hAlign(.center)
                        .background{
                            Capsule()
                                .fill(animateColor.gradient)
                        }
                }
                .vAlign(.bottom)
                .disabled(taskName == "" || animate)
                .opacity(taskName == "" ? 0.6 : 1)
            }
            .padding(15)
        }
        .vAlign(.top)
    }
    
    @ViewBuilder
    func TitleView(_ value: String, _ color: Color = .white.opacity(0.7)) -> some View{
        Text(value)
            .ubuntu(12, weight: .regular)
            .foregroundStyle(color)
    }
}

#Preview {
    AddTaskView()
}
