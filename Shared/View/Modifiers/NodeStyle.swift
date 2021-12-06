//
//  TaskNodeStyle.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/12/06.
//

import Foundation
import SwiftUI
struct NodeStyle: ViewModifier{
    let color:Color
    func body(content: Content) -> some View {
        content
            .padding(4)
            .background(RoundedRectangle(cornerRadius: 8).fill(.regularMaterial))
            .background(RoundedRectangle(cornerRadius: 8).stroke(color, lineWidth: 2))
    }
}
