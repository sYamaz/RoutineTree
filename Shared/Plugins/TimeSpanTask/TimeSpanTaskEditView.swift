//
//  TimeSpanTaskEditView.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/18.
//

import SwiftUI

struct TimeSpanTaskEditView: View {
    @Binding var task:RoutineTask
    @Binding var editing:TaskId?
    let factory:AddNewTaskButtonFactory = .init()
    
    var body: some View {
        RoutineEditView(task: $task, editingTaskId: $editing){t in
            Section("timer"){
                VStack{
                    MinSecPicker(min: $task.minutes, sec: $task.seconds)
                }
            }
        }
    }
}

struct TimeSpanTaskEditView_Previews: PreviewProvider {
    static var previews: some View {
        let task:RoutineTask = .init(id: .init(id: .init()), type: .TimeSpan, title: "Task", description: "Description", properties: [
            "minutes":"1",
            "seconds":"20"
        ], tasks: .init())
        
        TimeSpanTaskEditView(task: .constant(task), editing: .constant(nil))
    }
}
