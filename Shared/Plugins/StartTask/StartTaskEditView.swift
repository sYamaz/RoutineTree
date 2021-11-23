//
//  StatrTaskEditView.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/20.
//

import SwiftUI

struct StartTaskEditView: View {
    let factory:AddNewTaskButtonFactory = .init()
    @Binding var appendable:Routine
    var body: some View {
        VStack(alignment: .leading, spacing: nil){
            Text("Next tasks")
            List{
                ForEach(appendable.tasks, id: \.id){t in
                    Button(t.title){
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
        let r = Routine(id: .init(id: .init()), title: "RoutineName", tasks: .init())
        
        StartTaskEditView(appendable: .constant(r))
    }
}
