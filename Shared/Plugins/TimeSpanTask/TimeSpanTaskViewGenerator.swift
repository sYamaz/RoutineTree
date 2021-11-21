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
    func generateTreeItemView(task: RoutineTask) -> AnyView {
        let vm = TimeSpanTaskListItemViewModel(task: task)
        return .init(NavigationLink(destination: {
            TimeSpanTaskEditView(vm:vm)
        }){
            TimeSpanTaskListItemView(vm: vm)}
                        .modifier(RoundedRectangleStyle())
        )
    }
}
