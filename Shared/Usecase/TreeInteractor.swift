//
//  TreeInteractor.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/12/08.
//

import Foundation
struct TreeInteractor{
    func deleteRoutineFromTree(tree:Tree, delete:Routine) -> Tree{
        var temp = tree
        
        if(temp.tasks.contains(where: {r in r.id == delete.id})){
            let child = delete.tasks
            let index = temp.tasks.firstIndex(where: {r in r.id == delete.id})!
            temp.tasks.remove(at: index)
            temp.tasks.append(contentsOf: child)
        } else {
            for i in temp.tasks.indices{
                temp.tasks[i] = deleteRoutineFromRoutine(routine: temp.tasks[i], delete: delete)
            }
        }
        
        return temp
    }
    
    func deleteRoutineFromRoutine(routine:Routine, delete:Routine) -> Routine{
        var temp = routine
        if(temp.tasks.contains(where: {r in r.id == delete.id})){
            // 対象のRoutineの子に削除対象が含まれていた場合
            let child = delete.tasks
            let index = temp.tasks.firstIndex(where: {r in r.id == delete.id})!
            temp.tasks.remove(at: index)
            temp.tasks.append(contentsOf: child)
        } else {
            for i in temp.tasks.indices {
                temp.tasks[i] = deleteRoutineFromRoutine(routine: temp.tasks[i], delete: delete)
            }
        }
        return temp
    }
}
