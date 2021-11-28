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
                }.padding(4)
            }else{
                ForEach($task.children, id:\.id){t in
                    TaskPlayingView(task: t, factory: self.factory)
                }
            }
        }
    }
}

struct TaskPlayingView_Previews: PreviewProvider {
    static var previews: some View {
        var task:RoutineTask = tutorialRoutine.tasks[0]
        TaskPlayingView(task: .constant(task), factory: taskViewFactory)
            .onAppear(perform: {task.visit()})
    }
}
