//
//  TimeSpanTaskListItemView.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/12.
//

import SwiftUI

struct TimeSpanTaskNodeView: View {
    
    @Binding var task:RoutineTask
    @Binding var editing:TaskId?
    
    var body: some View {
        Button(action:{
            self.editing = task.id
        }){
            RoutineNodeView(task: $task){t in
                HStack(alignment: .center, spacing: nil, content: {
                    Image(systemName: "clock")
                    Text(self.task.formattedTime)
                        .font(.caption)
                        .foregroundColor(.secondary)
                })
                
            }
        }
        .sheet(isPresented: .init(
            get: {
                if let id = self.editing{
                    return id.id == task.id.id
                }
                return false
            },
            set: { b in
                self.editing = b ? task.id : nil
            }
        ), onDismiss: {
            
        }, content: {
            TimeSpanTaskEditView(task: $task, editing: $editing)
        })
        .modifier(RoundedRectangleStyle(focused: false))
        
    }
}

struct TimeSpanTaskNodeView_Previews: PreviewProvider {
    static var previews: some View {
        
        let taskId = TaskId(id: .init())
        
        let task = RoutineTask(id: taskId, type: .TimeSpan, title: "Title", description: "Description",  properties: [
            "minutes":"5",
            "seconds":"30"
        ], tasks: .init())
        
        TimeSpanTaskNodeView(task: .constant(task), editing: .constant(nil))
    }
}
