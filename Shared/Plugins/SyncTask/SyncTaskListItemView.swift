//
//  SyncTaskListItemView.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/12.
//

import SwiftUI

struct SyncTaskNodeView: View {
  
    @Binding var task:RoutineTask
    @State private var editing = false
    var body: some View {
        Button(action: {
            task.editing = true
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
        .sheet(isPresented: $task.editing, onDismiss: {
            
        }, content: {
            SyncTaskEditView(task: $task)
        })
    }
}

struct SyncTaskNodeView_Previews: PreviewProvider {
    static var previews: some View {
        let task = RoutineTask(id: .init(id: .init()), type: .Sync, title: "Title", description: "Description",  properties: .init(),
                               children: .init())
        
        SyncTaskNodeView(task: .constant(task))
    }
}
