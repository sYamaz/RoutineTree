//
//  StatrTaskEditView.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/20.
//

import SwiftUI

struct StartTaskEditView: View {
    let factory:AddNewTaskButtonFactory = .init()
    @Binding var appendable:RoutineTree
    @Binding var editing:TaskId?
    var body: some View {
        VStack(alignment: .leading, spacing: nil){
            Text("Next tasks")
            List{
                ForEach(appendable.tasks, id: \.id){t in
                    Button(t.title){
                        editing = nil
                        editing = t.id
                    }
                }
            }
            
            Spacer()
            factory.generate(appendable: $appendable)
        }
        .padding()
    }
}

struct StartTaskEditView_Previews: PreviewProvider {
    static var previews: some View {
        let r = RoutineTree(id: .init(id: .init()), title: "RoutineName", tasks: .init())
        
        StartTaskEditView(appendable: .constant(r), editing: .constant(nil))
    }
}
