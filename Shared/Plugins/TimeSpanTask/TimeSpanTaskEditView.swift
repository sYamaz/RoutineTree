//
//  TimeSpanTaskEditView.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/18.
//

import SwiftUI

struct TimeSpanTaskEditView: View {
    @Binding var task:RoutineTask
    @Binding var editing:TaskId?
    let factory:AddNewTaskButtonFactory = .init()
    
    var body: some View {
        VStack(alignment: .leading, spacing: nil){
            TextField("", text: .init(get: {self.task.title}, set: {self.task.title = $0}), prompt: nil)
                .font(.title)
                .border(.secondary)
            TextEditor(text:.init(get: {self.task.description}, set: {self.task.description = $0}))
                .frame(height:100)
                .border(.secondary)
            
            HStack(alignment: .center, spacing: nil){
                Spacer()
                Picker("min", selection: .init(get: {self.task.getMinutes()}, set: {self.task.setMinutes($0)})){
                    ForEach(0..<60){m in
                        Text(String(m)).tag(m)
                    }
                }
                .pickerStyle(.wheel)
                .frame(width:70)
                .compositingGroup()
                .clipped()
                
                Text("min")
                
                Picker("sec", selection: .init(get: {self.task.getSeconds()}, set: {self.task.setSeconds($0)})){
                    ForEach(0..<60){Text(String($0)).tag($0)}
                }
                .pickerStyle(.wheel)
                .frame(width:70)
                .compositingGroup()
                .clipped()
                
                Text("sec")
                Spacer()
            }
            
            Text("Next tasks")
            List{
                ForEach(task.children, id: \.id){t in
                    Button(t.title){
                        editing = nil
                        editing = t.id
                    }
                }
            }
            
            Spacer()
            
            factory.generate(appendable: self.$task)
        }
        .padding()
    }
}

struct TimeSpanTaskEditView_Previews: PreviewProvider {
    static var previews: some View {
        let task:RoutineTask = .init(id: .init(id: .init()), type: .TimeSpan, title: "Task", description: "Description", properties: [
            "minutes":"1",
            "seconds":"20"
        ], children: .init())
        
        TimeSpanTaskEditView(task: .constant(task), editing: .constant(nil))
    }
}
