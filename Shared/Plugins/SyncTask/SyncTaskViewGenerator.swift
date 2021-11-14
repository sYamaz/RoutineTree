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
    
    let ps:PlayStore
    let db:TaskDatabaseDelegate
    
    init(ps:PlayStore, db:TaskDatabaseDelegate){
        self.ps = ps
        self.db = db
    }
    
    func generateNodeView(task: RoutineTask) -> AnyView {
        
        let vm = SyncTaskNodeViewModel(id: task.id, ps: self.ps, db: self.db)
        
        let view = SyncTaskNodeView(vm:vm)
        
        return .init(view)
    }
    
    func generateListItemView(task: RoutineTask) -> AnyView {
        let vm = SyncTaskListItemViewModel(taskId: task.id, taskDb: self.db)
        
        let view = SyncTaskListItemView(vm:vm)
        
        return .init(view)
    }
}
