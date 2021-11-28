//
//  TaskPlayingView.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/19.
//

import SwiftUI

struct RoutinePlayingView: View {
    @Binding var routine:RoutineTree
    let factory:TaskViewFactory
    
    var body: some View {
        ScrollView(){
            ForEach($routine.tasks, id: \.id){t in
                TaskPlayingView(task: t, factory: factory)
            }
        }
    }
}

struct RoutinePlayingView_Previews: PreviewProvider {
    static var previews: some View {
        var routine = makeStarted(routine: tutorialRoutine)
        RoutinePlayingView(routine: .constant(routine), factory: taskViewFactory)
            .onAppear(perform: {routine.start()})
    }
        
}
