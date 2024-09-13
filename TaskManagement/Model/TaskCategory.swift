//
//  TaskCategory.swift
//  TaskManagement
//
//  Created by xqsadness on 30/07/2024.
//

import SwiftUI

//MARK: Category enum with color
enum Category: String, CaseIterable, Codable{
    case general = "General"
    case bug = "Bug"
    case idea = "Idea"
    case modifiers = "Modifiers"
    case challenge = "Challenge"
    case coding = "Coding"
    
    var color: Color{
        switch self{
        case .general:
            return Color.cGray
        case .bug:
            return Color.cGreen
        case .idea:
            return Color.cPink
        case .modifiers:
            return Color.cBlue
        case .challenge:
            return Color.purple
        case .coding:
            return Color.brown
        }
    }
}
