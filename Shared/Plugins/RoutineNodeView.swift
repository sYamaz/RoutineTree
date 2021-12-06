//
//  RoutineNodeView.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/12/04.
//

import SwiftUI

struct RoutineNodeView: View {
    @Binding var task:RoutineTask
    @Binding var editing:TaskId?
    
    @State private var edit:Bool = false
    
    var body: some View {
        Button(action:{
            edit = true
        }){
            VStack(alignment: .leading, spacing: nil){
                Text(self.task.title)
                    .font(.body)
                    .lineLimit(1)
                    .foregroundColor(.primary)
                Text(self.task.description)
                    .font(.caption)
                    .lineLimit(1)
                    .foregroundColor(.secondary)
                if(self.task.type == .TimeSpan){
                    HStack(alignment: .center, spacing: nil, content: {
                        Image(systemName: "clock")
                        Text(self.task.formattedTime)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    })
                }else{
                    Text("")
                }
            }
        }
        .buttonStyle(.plain)
        .sheet(isPresented: $edit, onDismiss: {
            
        }, content: {
            RoutineEditView(task: $task, editingTaskId: $editing).textCase(nil)
        })
    }
}

struct RoutineNodeView_Previews: PreviewProvider {
    static var previews: some View {
        RoutineNodeView(task: .constant( tutorialRoutine.tasks[0]),
                        editing: .constant(nil))
        
    }
}
