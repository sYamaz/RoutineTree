//
//  TaskPlayingView.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/19.
//

import SwiftUI

struct TaskPlayingView: View {
    @ObservedObject var routine:Routine
    let factory:TaskViewFactory
    
    var body: some View {
        let tasks = flattenRoutine(r: self.routine)
                        .filter({t in t.doing})
        
        List(){
            ForEach(tasks, id: \.id){t in
                HStack(alignment: .center, spacing: nil){
                    Text(t.title)
                    Spacer()
                    Button("Done"){
                        print("Click")
                        t.markAsDone()
                    }
                }
            }
        }
    }
    
    private func flattenRoutine(r:Routine) -> [RoutineTask]{
        var tasks:[RoutineTask] = r.tasks
        tasks.append(contentsOf: r.tasks.flatMap{t in flattenChildren(task: t)})
        return tasks
    }
    
    private func flattenChildren(task:RoutineTask) -> [RoutineTask]{
        var ret:[RoutineTask] = task.children
        for c in task.children{
            ret.append(contentsOf: flattenChildren(task: c))
        }
        return ret
    }
}

struct TaskPlayingView_Previews: PreviewProvider {
    static var previews: some View {
        let routine = previewRoutine
        TaskPlayingView(routine: routine, factory: taskViewFactory)
            .onAppear(perform: {routine.start()})
    }
        
}
