//
//  TaskPlayingView.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/23.
//

import SwiftUI

struct TaskPlayingView: View {
    @Binding var task:RoutineTask
    let factory:TaskViewFactory
    
    var body: some View {
        VStack(alignment: .center, spacing: nil){
            if(task.doing == .Doing){
                HStack{
                factory.generatePlayView(task: $task).transition(.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .trailing)))
                        .transition(.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .trailing)))
                    Spacer()
                    Button(action: {
                        withAnimation{
                            self.task.markAsDone()
                        }
                    }, label: {
                        Text("Done")
                    })
                }
            }else{
                ForEach($task.children.indices, id:\.self){i in
                    TaskPlayingView(task: $task.children[i], factory: self.factory)
                }
            }
        }
    }
}

struct TaskPlayingView_Previews: PreviewProvider {
    static var previews: some View {
        var task:RoutineTask = .init(id: .init(id: .init()), type: .Sync, title: "Root", description: "Description", properties: .init(), children: [
            .init(id: .init(id: .init()), type: .Sync, title: "Child1", description: "Description", properties: .init(), children: [
                .init(id: .init(id: .init()), type: .Sync, title: "Child1-1", description: "Description", properties: .init(), children: .init()),
                .init(id: .init(id: .init()), type: .Sync, title: "Child1-2", description: "Description", properties: .init(), children: .init()),
            ]),
            .init(id: .init(id: .init()), type: .Sync, title: "Child2", description: "Description", properties: .init(), children: .init())
        ])
        
        TaskPlayingView(task: .constant(task), factory: taskViewFactory)
            .onAppear(perform: {task.visit()})
    }
}
