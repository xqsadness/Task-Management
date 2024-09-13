//
//  SwiftUIView.swift
//  TaskManagement
//
//  Created by xqsadness on 08/08/2024.
//

import SwiftUI

struct OffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
