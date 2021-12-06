//
//  TaskPlayingView.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/19.
//

import SwiftUI

struct TreePlayingView: View {
    @Binding var routine:PlayableTree
    let onCompleted:() -> Void
    var body: some View {
        if(PlayableTreeInteractor().allDone(tree: routine) == false){
            ScrollView(){
                ForEach($routine.tasks, id: \.id){t in
                    RoutinePlayingView(task: t)
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

struct TreePlayingView_Previews: PreviewProvider {
    static var previews: some View {
        let routine = tutorialRoutine
        TreePlayingView(routine: .constant(routine.makePlayable())){
            
        }
    }
    
}
