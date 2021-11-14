//
//  TimeSpanTaskListItemView.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/12.
//

import SwiftUI

struct TimeSpanTaskListItemView: View {
    @ObservedObject var vm:TimeSpanTaskListItemViewModel
    
    @State var editMode = false
    @State var editingTitle:String = ""
    @State var editingDescription:String = ""
    @State var editingMinutes:Int = 0
    @State var editingSeconds:Int = 0
    
    init(vm:TimeSpanTaskListItemViewModel){
        self.vm = vm
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: nil){
            Text(vm.title)
                .font(.body)
                .foregroundColor(.primary)
            Text(vm.description)
                .font(.caption)
                .foregroundColor(.secondary)
            Text("\(vm.minutes) min \(vm.seconds) sec")
                .font(.caption)
                .foregroundColor(.secondary)
            ProgressView(value: vm.progress)
                .progressViewStyle(.linear)
        }
        .onTapGesture {
            editMode = true
        }
        .sheet(isPresented: $editMode, onDismiss: {
            vm.update(title: self.editingTitle,
                      description: self.editingDescription,
                      minutes: self.editingMinutes,
                      seconds: self.editingSeconds)
        }){
            TimeSpanTaskEditView(editingTitle: $editingTitle,
                                 editingDescription: $editingDescription,
            editingTimerSeconds: $editingSeconds,
            editingTimerMinutes: $editingMinutes)
                .onAppear(perform: {
                    self.editingTitle = vm.title
                    self.editingDescription = vm.description
                    self.editingMinutes = vm.minutes
                    self.editingSeconds = vm.seconds
                })
        }
    }
}

struct TimeSpanTaskListItemView_Previews: PreviewProvider {
    static var previews: some View {
        
        let taskId = TaskId(id: .init())
        
        let task = RoutineTask(id: taskId, type: .TimeSpan, title: "Title", description: "Description", followingTaskId: .createAddNewTaskId(), properties: [
            "minutes":"5",
            "seconds":"30"
        ])
        
        let vm = TimeSpanTaskListItemViewModel(taskId: taskId, taskDb: TaskDatabase(tasks: [task]))
        
        TimeSpanTaskListItemView(vm: vm)
    }
}
