//
//  TaskPlayingView.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/19.
//

import SwiftUI

struct RoutinePlayingView: View {
    @Binding var routine:PlayableRoutineTree
    let onCompleted:() -> Void
    var body: some View {
        if(RoutineTreeInteractor().allDone(tree: routine) == false){
            ScrollView(){
                ForEach($routine.tasks, id: \.id){t in
                    TaskPlayingView(task: t)
                }
            }
        } else {
            VStack{
                Spacer()
                CompletedView(onClick: onCompleted)
                    .foregroundColor(colorTable[routine.colorId])
            }
        }
    }
}

struct RoutinePlayingView_Previews: PreviewProvider {
    static var previews: some View {
        let routine = tutorialRoutine
        RoutinePlayingView(routine: .constant(routine.makePlayable())){
            
        }
    }
    
}
