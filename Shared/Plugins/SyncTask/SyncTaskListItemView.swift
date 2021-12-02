//
//  SyncTaskListItemView.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/12.
//

import SwiftUI

struct SyncTaskNodeView: View {
  
    @Binding var task:RoutineTask
    @Binding var editing:TaskId?
    
    private func editingToBool(_ val:TaskId?) -> Bool{
        if let id = val{
            return id.id == task.id.id
        }
        return false
    }
    
    private func boolToEditing(_ val:Bool) -> TaskId?{
        if(val){
            return task.id
        } else {
            return nil
        }
    }
    
    var body: some View {
        
        Button(action: {
            self.editing = task.id
        }){
            VStack(alignment: .leading, spacing: nil){
                Text(self.task.title)
                    .font(.body)
                    .foregroundColor(.primary)
                Text(self.task.description)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .sheet(isPresented: .init(
            get: { editingToBool(self.editing)},
            set: { self.editing = boolToEditing($0)}
        ), onDismiss: {
            
        }, content: {
            SyncTaskEditView(task: $task, editing: $editing)
        })
        .modifier(RoundedRectangleStyle(focused: false))
    }
}

struct SyncTaskNodeView_Previews: PreviewProvider {
    static var previews: some View {
        let task = RoutineTask(id: .init(id: .init()), type: .Sync, title: "Title", description: "Description",  properties: .init(),
                               tasks: .init())
        
        SyncTaskNodeView(task: .constant(task), editing: .constant(nil))
    }
}
