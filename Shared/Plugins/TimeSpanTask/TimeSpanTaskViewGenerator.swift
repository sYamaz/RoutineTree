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
    let db: TaskDatabaseDelegate
    
    init(db:TaskDatabaseDelegate){
        self.db = db
    }
    
    func generateNodeView(task: RoutineTask) -> AnyView {
        return .init(Text("Node"))
    }
    
    func generateListItemView(task: RoutineTask) -> AnyView {
        let vm = TimeSpanTaskListItemViewModel(taskId: task.id, taskDb: self.db)
        let view = TimeSpanTaskListItemView(vm: vm)
        return .init(view)
    }
    
}
