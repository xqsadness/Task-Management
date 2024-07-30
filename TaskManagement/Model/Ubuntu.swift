//
//  Ubuntu.swift
//  TaskManagement
//
//  Created by darktech4 on 30/07/2024.
//

import SwiftUI

enum Ubuntu{
    case light
    case bold
    case medium
    case regular
    var weight: Font.Weight{
        switch self {
        case .light:
            return .light
        case .bold:
            return .bold
        case .medium:
            return .medium
        case .regular:
            return .regular
        }
    }
}
extension View{
    func ubuntu(_ size: CGFloat, weight: Ubuntu)->some View{
        self
            .font(.custom("Ubuntu", size: size))
            .fontWeight(weight.weight)
    }
}
