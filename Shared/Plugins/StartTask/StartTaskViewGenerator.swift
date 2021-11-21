//
//  StartTaskViewGenerator.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/19.
//

import Foundation
import SwiftUI
class StartTaskViewGenerator:TaskTypeGeneratorDelegate{
    var type: TaskType = .Start
    func generateTreeItemView(task: RoutineTask) -> AnyView {
        return .init(
            NavigationLink(
                destination: {
                    StartTaskEditView(appendable: task)
                },
                label: {
                    Text("Start")
                })
                .modifier(DashRoundedRectangleStyle()))
    }

}
