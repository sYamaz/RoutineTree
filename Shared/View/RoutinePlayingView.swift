//
//  TaskPlayingView.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/19.
//

import SwiftUI

struct RoutinePlayingView: View {
    @Binding var routine:Routine
    let factory:TaskViewFactory
    
    var body: some View {
        ScrollView(){
            ForEach($routine.tasks.indices, id: \.self){index in
                TaskPlayingView(task: $routine.tasks[index], factory: factory)
            }
        }
    }
    
    private func allDone(tasks:[RoutineTask]) -> Bool{
        for task in tasks{
            if(task.doing != .Done){
                return false
            }
            if(allDone(tasks: task.children) == false){
                return false
            }
        }
        
        return true
    }
}

struct RoutinePlayingView_Previews: PreviewProvider {
    static var previews: some View {
        var routine = previewRoutine
        RoutinePlayingView(routine: .constant(routine), factory: taskViewFactory)
            .onAppear(perform: {routine.start()})
    }
        
}
