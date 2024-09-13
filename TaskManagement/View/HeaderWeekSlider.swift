//
//  HeaderViewWeekSlider.swift
//  TaskManagement
//
//  Created by xqsadness on 30/07/2024.
//

import SwiftUI

struct HeaderWeekSlider: View {
    
    @Binding var currentDate: Date
    @Binding var addNewTask: Bool
    
    @State private var weekSlider: [[Date.WeekDay]] = []
    @State private var currentWeekIndex: Int = 1
    @State private var createWeek: Bool = false
    //Animation namespace
    @Namespace private var animation
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            HeaderView()
        }
        .padding(15)
        .background{
            VStack(spacing: 0){
                Color.white
                
                //Gradient opacity background
                Rectangle()
                    .fill(.linearGradient(colors: [
                        .white,
                        .clear
                    ], startPoint: .top, endPoint: .bottom))
                    .frame(height: 20)
            }
            .ignoresSafeArea()
        }
        .onAppear{
            if weekSlider.isEmpty{
                let currentWeek = Date().fetchWeek()
                
                if let firstDate = currentWeek.first?.date{
                    weekSlider.append(firstDate.createPreviousWeek())
                }
                
                weekSlider.append(currentWeek)
                
                if let lastDate = currentWeek.last?.date{
                    weekSlider.append(lastDate.createNextWeek())
                }
            }
        }
    }
    
    @ViewBuilder
    func HeaderView() -> some View{
        VStack(alignment: .leading, spacing: 6){
            HStack{
                Text("Welcome, xqsadness")
                    .ubuntu(28, weight: .bold)
                    .foregroundStyle(.black).opacity(0.7)
                
                Spacer()
                
                Button{
                    addNewTask.toggle()
                }label: {
                    HStack{
                        Image(systemName: "plus")
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal, 10)
                    .background{
                        Capsule()
                            .fill(Color.cBlue.gradient)
                    }
                    .foregroundStyle(.white)
                }
                
                Button{
                    withAnimation{
                        currentDate = Date()
                        
                        let currentWeek = currentDate.fetchWeek()
                        
                        weekSlider = []
                        if let firstDate = currentWeek.first?.date {
                            weekSlider.append(firstDate.createPreviousWeek())
                        }
                        
                        weekSlider.append(currentWeek)
                        
                        if let lastDate = currentWeek.last?.date {
                            weekSlider.append(lastDate.createNextWeek())
                        }
                        
                        currentWeekIndex = 1
                    }
                }label: {
                    HStack{
                        Image(systemName: "timer")
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal, 10)
                    .background{
                        Capsule()
                            .fill(Color.cBlue.gradient)
                    }
                    .foregroundStyle(.white)
                }
            }
            
            VStack{
                HStack(spacing: 5){
                    Text(currentDate.toString("MMMM"))
                        .foregroundStyle(.cBlue)
                    
                    Text(currentDate.toString("YYYY"))
                        .foregroundStyle(.gray)
                }
                .font(.title.bold())
                .hAlign(.leading)
                
                Text(currentDate.formatted(date: .complete, time: .omitted))
                    .font(.callout)
                    .fontWeight(.semibold)
                    .textScale(.secondary)
                    .foregroundStyle(.gray)
                    .hAlign(.leading)
            }
            
            //Week slider
            TabView(selection: $currentWeekIndex){
                ForEach(weekSlider.indices, id: \.self){ index in
                    let week = weekSlider[index]
                    
                    WeekView(week)
                        .padding(.horizontal, 15)
                        .tag(index)
                }
            }
            .padding(.horizontal, -15)
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(height: 90)
        }
        .hAlign(.leading)
        .onChange(of: currentWeekIndex, initial: false) { oldValue, newValue in
            //Creating when it reaches first/last page
            if newValue == 0 || newValue == (weekSlider.count - 1){
                createWeek = true
            }
        }
    }
    
    @ViewBuilder
    func WeekView(_ week: [Date.WeekDay]) -> some View{
        HStack(spacing: 0){
            ForEach(week){ day in
                VStack(spacing: 8){
                    Text(day.date.toString("E"))
                        .font(.callout)
                        .fontWeight(.medium)
                        .textScale(.secondary)
                        .foregroundStyle(.gray)
                    
                    Text(day.date.toString("dd"))
                        .font(.callout)
                        .fontWeight(.bold)
                        .textScale(.secondary)
                        .foregroundStyle(isSameDate(day.date, currentDate) ? .white : .gray)
                        .frame(width: 35, height: 35)
                        .background{
                            if isSameDate(day.date, currentDate){
                                Circle()
                                    .fill(.cBlue)
                                    .matchedGeometryEffect(id: "TABINDICATOR", in: animation)
                            }
                            
                            if day.date.isToday{
                                Circle()
                                    .fill(.cyan)
                                    .frame(width: 5, height: 5)
                                    .vAlign(.bottom)
                                    .offset(y: 12)
                            }
                        }
                        .background(.white.shadow(.drop(radius: 1)), in: .circle)
                }
                .hAlign(.center)
                .contentShape(.rect)
                .onTapGesture {
                    withAnimation(.snappy){
                        currentDate = day.date
                    }
                }
            }
        }
        .background{
            GeometryReader{
                let minX = $0.frame(in: .global).minX
                
                Color.clear
                    .preference(key: OffsetKey.self, value: minX)
                    .onPreferenceChange(OffsetKey.self){ value in
                        if value.rounded() == 15 && createWeek{
                            paginateWeek()
                            createWeek = false
                        }
                    }
            }
        }
    }
    
    func paginateWeek() {
        /// SafeCheck
        if weekSlider.indices.contains(currentWeekIndex) {
            if let firstDate = weekSlider[currentWeekIndex].first?.date, currentWeekIndex ==
                0 {
                /// Inserting New Week at 0th Index and Removing Last Array Item
                weekSlider.insert(firstDate.createPreviousWeek(), at: 0)
                weekSlider.removeLast()
                currentWeekIndex = 1
            }
            if let lastDate = weekSlider [currentWeekIndex].last?.date, currentWeekIndex ==
                (weekSlider.count - 1) {
                /// Appending New Week at Last Index and Removing First Array Item
                weekSlider.append(lastDate.createNextWeek())
                weekSlider.removeFirst()
                currentWeekIndex = weekSlider.count - 2
            }
        }
    }
}

//#Preview {
//    HeaderWeekSlider()
//}
