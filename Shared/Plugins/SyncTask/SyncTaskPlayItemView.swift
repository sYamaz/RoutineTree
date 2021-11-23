//
//  SyncTaskPlayItemView.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/15.
//

import SwiftUI

struct SyncTaskPlayItemView: View {
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
            }
            Spacer()
            Button(action: {
                self.task.markAsDone()
            }, label: {
                Text("Done")
            })
        }
    }
}

struct SyncTaskPlayItemView_Previews: PreviewProvider {
    static var previews: some View {
        let task = RoutineTask(id: .init(id: .init()), type: .Sync, title: "Title", description: "Description", properties: .init(), children:.init())

        SyncTaskPlayItemView(task: .constant(task))
    }
}
