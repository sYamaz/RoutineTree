//
//  SyncTaskEditView.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/12.
//

import SwiftUI

struct SyncTaskEditView: View {
    @State private var taskId:TaskId = .createStartTaskId()
    
    @ObservedObject var vm:SyncTaskListItemViewModel
    
    let factory:AddNewTaskButtonFactory = .init()
    
    init(vm:SyncTaskListItemViewModel){
        self.vm = vm
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: nil){

            TextField("", text: .init(get: {vm.task.title}, set: {vm.task.title = $0}), prompt: nil)
                    .font(.title)
                    .border(.secondary)
            TextEditor(text:.init(get: {vm.task.description}, set: {vm.task.description = $0}))
                    .frame(height:100)
                    .border(.secondary)
            
            Spacer()
            
            factory.generate(appendable: self.vm.task)
        }
        .padding()
    }
}

struct SyncTaskEditView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            SyncTaskEditView(vm:.init(task: .init(id: .init(id: .init()), type: .Sync, title: "Title", description: "Description", properties: .init(), children: .init())))
        }
    }
}
