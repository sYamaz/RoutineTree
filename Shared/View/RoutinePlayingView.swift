//
//  TaskPlayingView.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/19.
//

import SwiftUI

struct RoutinePlayingView: View {
    @Binding var routine:PlayableRoutineTree
    let factory:TaskViewFactory
    let onCompleted:() -> Void
    var body: some View {
        if(RoutineTreeInteractor().allDone(tree: routine) == false){
            ScrollView(){
                ForEach($routine.tasks, id: \.id){t in
                    TaskPlayingView(task: t, factory: factory)
                }
            }
        } else {
            VStack{
                Spacer()
                CompletedView(onClick: onCompleted)
            }
        }
    }
}

struct RoutinePlayingView_Previews: PreviewProvider {
    static var previews: some View {
        let routine = tutorialRoutine
        RoutinePlayingView(routine: .constant(routine.makePlayable()), factory: taskViewFactory){
            
        }
    }
    
}
