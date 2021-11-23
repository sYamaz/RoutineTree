//
//  TimeSpanTaskPlayItemView.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/15.
//

import SwiftUI

struct TimeSpanTaskPlayItemView: View {

    @Binding var task:RoutineTask
    var body: some View {
        HStack(alignment: .center, spacing: nil){
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
            Spacer()
            Button(action: {
                
            }, label: {
                Text("Done")
            })
        }
    }
}

struct TimeSpanTaskPlayItemView_Previews: PreviewProvider {
    static var previews: some View {
        let taskId = TaskId(id: .init())
        
        let task = RoutineTask(id: taskId, type: .TimeSpan, title: "Title", description: "Description",  properties: [
            "minutes":"5",
            "seconds":"30"
        ],children: .init())
        
        
        TimeSpanTaskPlayItemView(task: .constant(task))
    }
}
