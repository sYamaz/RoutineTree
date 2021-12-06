//
//  RoutineInteractor.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/12/07.
//

import Foundation
struct PlayableRoutineInteractor{
    func allDone(task:PlayableRoutine) -> Bool{
        if(task.doing != .Done){
            return false
        }
        
        for i in task.children.indices {
            if(self.allDone(task: task.children[i]) == false){
                return false
            }
        }
        
        return true
    }
    
    func markAsDone(task: PlayableRoutine) -> PlayableRoutine{
        var t = task
        t.doing = .Done
        for i in t.children.indices{
            t.children[i].doing = .Doing
            t.children[i].lastStartAt = Date()
        }
        return t
    }
    
    func forceFinished(task:inout PlayableRoutine) -> Void{
        task.doing = .None
        for i in task.children.indices{
            forceFinished(task: &task.children[i])
        }
    }
}
