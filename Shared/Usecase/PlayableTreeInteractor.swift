//
//  RoutineTreeInteractor.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/12/01.
//

import Foundation
struct PlayableTreeInteractor{
    private let routineInteractor:PlayableRoutineInteractor = .init()
    
    func start( tree: PlayableTree) -> PlayableTree{
        var tr = tree
        for i in tree.tasks.indices{
            tr.tasks[i].doing = .Doing
            tr.tasks[i].lastStartAt = Date()
        }
        
        return tr
    }
    
    func forceFinished( tree:inout PlayableTree) -> Void{
//        func recurse(task:inout PlayableRoutine) -> Void{
//            task.doing = .None
//            for i in task.children.indices{
//                recurse(task: &task.children[i])
//            }
//        }
        
        for i in tree.tasks.indices{
            routineInteractor.forceFinished(task: &tree.tasks[i])
        }
    }
    
    func allDone(tree:PlayableTree) -> Bool{
        for i in tree.tasks.indices{
            if(routineInteractor.allDone(task: tree.tasks[i]) == false){
                return false
            }
        }
        
        return true
    }
}
