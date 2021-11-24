//
//  ImmediateTaskViewGenerator.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/06.
//

import Foundation
import SwiftUI
class SyncTaskViewGenerator: TaskTypeGeneratorDelegate{
    var type: TaskType = .Sync
    func generateNodeView(task: Binding<RoutineTask>, editing:Binding<TaskId?>) -> AnyView {
        return .init(SyncTaskNodeView(task: task, editing: editing))
    }
    
    func generatePlayView(task:Binding<RoutineTask>) -> AnyView{
        return .init(SyncTaskPlayItemView(task: task))
    }
}
