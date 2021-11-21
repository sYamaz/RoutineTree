//
//  TimeSpanTaskListItemView.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/12.
//

import SwiftUI

struct TimeSpanTaskListItemView: View {
    @ObservedObject var vm:TimeSpanTaskListItemViewModel
    
    init(vm:TimeSpanTaskListItemViewModel){
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
            Text("\(vm.task.getMinutes()) min \(vm.task.getSeconds()) sec")
                .font(.caption)
                .foregroundColor(.secondary)
            ProgressView(value: 0.3)
                .progressViewStyle(.linear)
        }
    }
}

struct TimeSpanTaskListItemView_Previews: PreviewProvider {
    static var previews: some View {
        
        let taskId = TaskId(id: .init())
        
        let task = RoutineTask(id: taskId, type: .TimeSpan, title: "Title", description: "Description",  properties: [
            "minutes":"5",
            "seconds":"30"
        ], children: .init())
        
        let vm = TimeSpanTaskListItemViewModel(task: task)
        
        TimeSpanTaskListItemView(vm: vm)
    }
}
