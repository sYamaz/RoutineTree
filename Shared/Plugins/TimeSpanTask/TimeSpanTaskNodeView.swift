//
//  TimeSpanTaskListItemView.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/12.
//

import SwiftUI

struct TimeSpanTaskNodeView: View {

    @Binding var task:RoutineTask
    @State var editing:Bool = false
    
    var body: some View {
        Button(action:{
            task.editing = true
        }){
            VStack(alignment: .leading, spacing: nil){
                Text(self.task.title)
                    .font(.body)
                    .foregroundColor(.primary)
                Text(self.task.description)
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text("\(self.task.getMinutes()) min \(self.task.getSeconds()) sec")
                    .font(.caption)
                    .foregroundColor(.secondary)
                ProgressView(value: 0.3)
                    .progressViewStyle(.linear)
            }
        }
        .sheet(isPresented: $task.editing, onDismiss: {
            
        }, content: {
            TimeSpanTaskEditView(task: $task)
        })
    }
}

struct TimeSpanTaskNodeView_Previews: PreviewProvider {
    static var previews: some View {
        
        let taskId = TaskId(id: .init())
        
        let task = RoutineTask(id: taskId, type: .TimeSpan, title: "Title", description: "Description",  properties: [
            "minutes":"5",
            "seconds":"30"
        ], children: .init())

        TimeSpanTaskNodeView(task: .constant(task))
    }
}
