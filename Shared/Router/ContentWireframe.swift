//
//  ContentWireframe.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/06.
//

import Foundation
import SwiftUI
protocol ContentWireframe {
    associatedtype V
    func getRoutineView(routine:Binding<RoutineTree>) -> V
}
