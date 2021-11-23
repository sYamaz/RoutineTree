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
    func generateNodeView(task: Binding<RoutineTask>) -> AnyView {
        return .init(NavigationLink(destination: {
            SyncTaskEditView(task: task)
        }){
            SyncTaskNodeView(task: task)
                .modifier(RoundedRectangleStyle())
        })
    }
}
