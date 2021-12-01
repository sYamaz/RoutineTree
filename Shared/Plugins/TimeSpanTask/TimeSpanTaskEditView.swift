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
                HStack(alignment: .center, spacing: nil){
                    Spacer()
                    Picker("min", selection: .init(get: {t.wrappedValue.getMinutes()}, set: {t.wrappedValue.setMinutes($0)})){
                        ForEach(0..<60){m in
                            Text(String(m)).tag(m)
                        }
                    }
                    .pickerStyle(.wheel)
                    .frame(width:70)
                    .compositingGroup()
                    .clipped()
                    
                    Text("min")
                    
                    Picker("sec", selection: .init(get: {t.wrappedValue.getSeconds()}, set: {t.wrappedValue.setSeconds($0)})){
                        ForEach(0..<60){Text(String($0)).tag($0)}
                    }
                    .pickerStyle(.wheel)
                    .frame(width:70)
                    .compositingGroup()
                    .clipped()
                    
                    Text("sec")
                    Spacer()
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
        ], children: .init())
        
        TimeSpanTaskEditView(task: .constant(task), editing: .constant(nil))
    }
}
