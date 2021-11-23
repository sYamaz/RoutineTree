//
//  SyncTaskEditView.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/12.
//

import SwiftUI

struct SyncTaskEditView: View {
    @Binding var task:RoutineTask
    let factory:AddNewTaskButtonFactory = .init()
    
    var body: some View {
        VStack(alignment: .leading, spacing: nil){

            TextField("", text: .init(get: {self.task.title}, set: {self.task.title = $0}), prompt: nil)
                    .font(.title)
                    .border(.secondary)
            TextEditor(text:.init(get: {self.task.description}, set: {self.task.description = $0}))
                    .frame(height:100)
                    .border(.secondary)
            
            Spacer()
            
            Text("Next tasks")
            List{
                ForEach(task.children, id: \.id){t in
                    Text(t.title)
                }
            }
            
            factory.generate(appendable: self.$task)
        }
        .padding()
    }
}

struct SyncTaskEditView_Previews: PreviewProvider {
    static var previews: some View {
        
        let task = RoutineTask(id: .init(id: .init()), type: .Sync, title: "Title", description: "Description", properties: .init(), children: .init())
        
        NavigationView{
            SyncTaskEditView(task: .constant(task))
        }
    }
}
