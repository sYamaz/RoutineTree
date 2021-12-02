//
//  SyncTaskEditView.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/12.
//

import SwiftUI

struct SyncTaskEditView: View {
    @Binding var task:RoutineTask
    @Binding var editing:TaskId?
    let factory:AddNewTaskButtonFactory = .init()
    
    var body: some View {
        RoutineEditView(task: $task, editingTaskId: $editing){t in
            EmptyView()
        }
    }
}

struct SyncTaskEditView_Previews: PreviewProvider {
    static var previews: some View {
        
        let task = RoutineTask(id: .init(id: .init()), type: .Sync, title: "Title", description: "Description", properties: .init(), tasks: .init())
        

            SyncTaskEditView(task: .constant(task), editing: .constant(nil))
        
    }
}
