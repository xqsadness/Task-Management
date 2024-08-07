//
//  HeaderViewWeekSlider.swift
//  TaskManagement
//
//  Created by darktech4 on 30/07/2024.
//

import SwiftUI

struct HeaderViewWeekSlider: View {
    
    @State private var currentDate: Date = .init()
    @State private var weekSlider: [[Date.WeekDay]] = []
    @State private var currentWeekIndex: Int = 1
    @State private var createWeek: Bool = false
    //Animation namespace
    @Namespace private var animation
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            HeaderView()
        }
        .vAlign(.top)
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
            HStack(spacing: 5){
                Text(currentDate.toString("MMMM"))
                    .foregroundStyle(.cBlue)
                
                Text(currentDate.toString("YYYY"))
                    .foregroundStyle(.gray)
            }
            .font(.title.bold())
            
            Text(currentDate.formatted(date: .complete, time: .omitted))
                .font(.callout)
                .fontWeight(.semibold)
                .textScale(.secondary)
                .foregroundStyle(.gray)
            
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
        .padding(15)
        .hAlign(.leading)
        .background(.white)
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
    }
}

#Preview {
    HeaderViewWeekSlider()
}
