//
//  DashRoundedRectangleStyle.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/25.
//

import Foundation
import SwiftUI

struct DashRoundedRectangleStyle: ViewModifier{
    func body(content: Content) -> some View {
        content
            .padding(4)
            .background(RoundedRectangle(cornerRadius: 8).stroke(style: StrokeStyle(lineWidth: 1, lineCap: .round, lineJoin: .round, miterLimit: 1, dash: [2], dashPhase: 1)))
            .background(RoundedRectangle(cornerRadius: 8).fill(.background))
    }
}
