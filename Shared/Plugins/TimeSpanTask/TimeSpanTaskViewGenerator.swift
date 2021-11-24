//
//  TimeSpanTaskViewGenerator.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/13.
//

import Foundation
import SwiftUI

class TimeSpanTaskViewGenerator: TaskTypeGeneratorDelegate{
    var type: TaskType = .TimeSpan
    func generateNodeView(task: Binding<RoutineTask>, editing:Binding<TaskId?>) -> AnyView {
        return .init(TimeSpanTaskNodeView(task: task, editing: editing))
    }
    
    func generatePlayView(task:Binding<RoutineTask>) -> AnyView{
        return .init(TimeSpanTaskPlayItemView(task: task))
    }
}
