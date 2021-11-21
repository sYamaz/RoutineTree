//
//  TimeSpanTaskEditView.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/18.
//

import SwiftUI

struct TimeSpanTaskEditView: View {
    @ObservedObject var vm:TimeSpanTaskListItemViewModel
    let factory:AddNewTaskButtonFactory = .init()
    
    var body: some View {
        VStack(alignment: .leading, spacing: nil){
            TextField("", text: .init(get: {vm.task.title}, set: {vm.task.title = $0}), prompt: nil)
                .font(.title)
                .border(.secondary)
            TextEditor(text:.init(get: {vm.task.description}, set: {vm.task.description = $0}))
                .frame(height:100)
                .border(.secondary)
            
            HStack(alignment: .center, spacing: nil){
                Spacer()
                Picker("min", selection: .init(get: {vm.task.getMinutes()}, set: {vm.task.setMinutes($0)})){
                    ForEach(0..<60){m in
                        Text(String(m)).tag(m)
                    }
                }
                .pickerStyle(.wheel)
                .frame(width:70)
                .compositingGroup()
                .clipped()
                
                Text("min")
                
                Picker("sec", selection: .init(get: {vm.task.getSeconds()}, set: {vm.task.setSeconds($0)})){
                    ForEach(0..<60){Text(String($0)).tag($0)}
                }
                .pickerStyle(.wheel)
                .frame(width:70)
                .compositingGroup()
                .clipped()
                
                Text("sec")
                Spacer()
            }
            
            Spacer()
            
            factory.generate(appendable: self.vm.task)
        }
        .padding()
    }
}

struct TimeSpanTaskEditView_Previews: PreviewProvider {
    static var previews: some View {
        TimeSpanTaskEditView(vm:.init(task: .init(id: .init(id: .init()), type: .TimeSpan, title: "Task", description: "Description", properties: [
            "minutes":"1",
            "seconds":"20"
        ], children: .init())))
    }
}
