//
//  TaskPlayingView.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/23.
//

import SwiftUI

struct TaskPlayingView: View {
    @Binding var task:PlayableRoutineTask
    let factory:TaskViewFactory
    
    var body: some View {
        VStack(alignment: .center, spacing: nil){
            if(task.doing == .Doing){
                HStack{
                    UIGCheckBox(label: {
                        HStack(alignment: .center, spacing: nil){
                            factory.generatePlayView(task: $task)
                            Spacer()
                        }
                    }, checkedChanged: {
                        if($0){
                            withAnimation(Animation.easeInOut.delay(0.2)){
                                self.task = RoutineTreeInteractor().markAsDone(task: self.task)
                            }
                        }
                    })
                    
                }
                    .transition(
                        .asymmetric(
                            insertion: .move(edge: .trailing),
                            removal: .move(edge: .leading)))
                    .padding(4)
                Divider()
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
        let task:RoutineTask = tutorialRoutine.tasks[0]
        TaskPlayingView(task: .constant(task.makePlayable()), factory: taskViewFactory)
    }
}
