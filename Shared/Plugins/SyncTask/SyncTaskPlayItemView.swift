//
//  SyncTaskPlayItemView.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/15.
//

import SwiftUI

struct SyncTaskPlayItemView: View {
    let vm:SyncTaskListItemViewModel
    init(vm: SyncTaskListItemViewModel){
        self.vm = vm
    }
    var body: some View {
        HStack(alignment: .center, spacing: nil){
            VStack(alignment: .leading, spacing: nil){
                Text(vm.task.title)
                    .font(.body)
                    .foregroundColor(.primary)
                Text(vm.task.description)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            Spacer()
            Button(action: {
                vm.markAsDone()
            }, label: {
                Text("Done")
            })
        }
    }
}

struct SyncTaskPlayItemView_Previews: PreviewProvider {
    static var previews: some View {
        let task = RoutineTask(id: .init(id: .init()), type: .Sync, title: "Title", description: "Description", properties: .init(), children:.init())
        let vm = SyncTaskListItemViewModel(task: task)
        
        SyncTaskPlayItemView(vm:vm)
    }
}
