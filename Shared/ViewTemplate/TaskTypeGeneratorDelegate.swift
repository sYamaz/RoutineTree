//
//  TaskTypeGeneratorDelegate.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/11.
//

import Foundation
import SwiftUI
protocol TaskTypeGeneratorDelegate{
    var type:TaskType{get}
    func generateTreeItemView(task:RoutineTask) -> AnyView
}
