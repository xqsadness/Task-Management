//
//  ContentView.swift
//  TaskManagement
//
//  Created by xqsadness on 26/07/2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var currentDate: Date = .init()
    
    //WeekSlider
    @State private var weekSlider: [[Date.WeekDay]] = []
    @State private var currentWeekIndex: Int = 1
    //Animation namespace
    @Namespace private var animation
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            VStack(alignment: .leading){
                Text("Calendar")
                    .font(.system(size: 36, weight: .semibold))
                
                //Week Slider
                TabView(selection: $currentWeekIndex){
                    ForEach(weekSlider.indices, id: \.self){ index in
                        let week = weekSlider[index]
                        
                        weekView(week)
                            .tag(index)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .frame(height: 90)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background{
                Rectangle().fill(.gray.opacity(0.1))
                    .clipShape(.rect(bottomLeadingRadius: 30, bottomTrailingRadius: 30))
                    .ignoresSafeArea()
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .onAppear{
            if weekSlider.isEmpty{
                let currentWeek = Date().fetchWeek()
          
                if let firstDate = currentWeek.first?.date{
                    weekSlider.append(firstDate.createPreviosWeek())
                }
                weekSlider.append(currentWeek)
                
                if let lastDate = currentWeek.last?.date{
                    weekSlider.append(lastDate.createNextWeek())
                }
            }
        }
    }
    
    //Week view
    @ViewBuilder
    func weekView(_ week: [Date.WeekDay]) -> some View{
        HStack(spacing: 0){
            ForEach(week){ day in
                VStack{
                    Text(day.date.format("E"))
                        .font(.callout)
                        .fontWeight(.medium)
                        .textScale(.secondary)
                        .foregroundStyle(.gray)
                    
                    Text(day.date.format("dd"))
                        .font(.system(size: 20))
                        .frame(width: 50, height: 55)
                        .foregroundStyle(isSameDate(day.date, currentDate) ? .white : .black)
                        .background(content: {
                            if isSameDate(day.date, currentDate){
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(.black)
                                    .offset(y: 3)
                                    .matchedGeometryEffect(id: "TABINDICATOR", in: animation)
                            }
                            
                            if day.date.isToday{
                                Circle()
                                    .fill(.white)
                                    .frame(width: 5, height: 5)
                                    .vSpacing(.bottom)
                            }
                        })
                }
                .hSpacing(.center)
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
            }
        }
    }
}

#Preview {
    ContentView()
}
