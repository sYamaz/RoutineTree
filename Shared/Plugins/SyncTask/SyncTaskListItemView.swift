//
//  SyncTaskListItemView.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/12.
//

import SwiftUI

struct SyncTaskListItemView: View {
    @ObservedObject private var vm:SyncTaskListItemViewModel
    
    @State var editMode = false
    @State var editingTItle:String = ""
    @State var editingDescription:String = ""
    
    init(vm: SyncTaskListItemViewModel){
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
        }
        .onTapGesture {
            editMode = true
        }
        .sheet(isPresented: $editMode, onDismiss: {
            vm.update(editingTitle: self.editingTItle, editingDescription: self.editingDescription)
        }){
            SyncTaskEditView(editingTitle: $editingTItle, editingDescription: $editingDescription)
                .onAppear(perform: {
                    self.editingTItle = vm.title
                    self.editingDescription = vm.description
                })
        }
    }
}

struct SyncTaskListItemView_Previews: PreviewProvider {
    static var previews: some View {
        let task = RoutineTask(id: .init(id: .init()), type: .Sync, title: "Title", description: "Description", followingTaskId: .createAddNewTaskId(), properties: .init())
        let db = TaskDatabase(tasks: [task])
        
        let vm = SyncTaskListItemViewModel(taskId: task.id, taskDb: db)
        
        SyncTaskListItemView(vm:vm)
    }
}
