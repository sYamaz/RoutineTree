//
//  SyncTaskListItemView.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/12.
//

import SwiftUI

struct SyncTaskListItemView: View {
    @ObservedObject private var vm:SyncTaskListItemViewModel

    init(vm: SyncTaskListItemViewModel){
        self.vm = vm
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: nil){
            Text(vm.task.title)
                .font(.body)
                .foregroundColor(.primary)
            Text(vm.task.description)
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
}

struct SyncTaskListItemView_Previews: PreviewProvider {
    static var previews: some View {
        let task = RoutineTask(id: .init(id: .init()), type: .Sync, title: "Title", description: "Description",  properties: .init(),
                               children: .init())
        
        let vm = SyncTaskListItemViewModel(task: task)
        
        SyncTaskListItemView(vm:vm)
    }
}
