//
//  TaskPlayingView.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/23.
//

import SwiftUI

struct RoutinePlayingView: View {
    @Binding var task:PlayableRoutineTask
    var body: some View {
        VStack(alignment: .center, spacing: nil){
            if(task.doing == .Doing){
                HStack{
                    UIGCheckBox(label: {
                        HStack(alignment: .center, spacing: nil){
                            RoutinePlayItemView(task: $task)
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
                    RoutinePlayingView(task: t)
                }
            }
        }
    }
}

struct RoutinePlayingView_Previews: PreviewProvider {
    static var previews: some View {
        let task:Routine = tutorialRoutine.tasks[0]
        RoutinePlayingView(task: .constant(task.makePlayable()))
    }
}
