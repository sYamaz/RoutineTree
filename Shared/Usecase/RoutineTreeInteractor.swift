//
//  RoutineTreeInteractor.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/12/01.
//

import Foundation
struct RoutineTreeInteractor{
    func start( tree: PlayableRoutineTree) -> PlayableRoutineTree{
        var tr = tree
        for i in tree.tasks.indices{
            tr.tasks[i].doing = .Doing
            tr.tasks[i].lastStartAt = Date()
        }
        
        return tr
    }
    
    func forceFinished( tree:inout PlayableRoutineTree) -> Void{
        func recurse(task:inout PlayableRoutine) -> Void{
            task.doing = .None
            for i in task.children.indices{
                recurse(task: &task.children[i])
            }
        }
        
        for i in tree.tasks.indices{
            recurse(task: &tree.tasks[i])
        }
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
    
    func allDone(tree:PlayableRoutineTree) -> Bool{
        for i in tree.tasks.indices{
            if(allDone(task: tree.tasks[i]) == false){
                return false
            }
        }
        
        return true
    }
    
    func allDone(task:PlayableRoutine) -> Bool{
        if(task.doing != .Done){
            return false
        }
        
        for i in task.children.indices {
            if(allDone(task: task.children[i]) == false){
                return false
            }
        }
        
        return true
    }
}
