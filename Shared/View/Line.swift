//
//  Line.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/25.
//

import Foundation
import SwiftUI
/// TaskとTaskを繋ぐ線
struct Line: Shape {
    var start, end: CGPoint

    func path(in rect: CGRect) -> Path {
        Path { p in
            p.move(to: start)
            p.addLine(to: end)
        }
    }
}


extension Line {
    var animatableData: AnimatablePair<CGPoint.AnimatableData, CGPoint.AnimatableData> {
        get { AnimatablePair(start.animatableData, end.animatableData) }
        set { (start.animatableData, end.animatableData) = (newValue.first, newValue.second) }
    }
}
