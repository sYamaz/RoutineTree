//
//  TreeInteractor.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/12/08.
//

import Foundation
struct TreeInteractor{
    func appendTo(tree:[Routine], element:Routine, targetId:RoutineId) -> [Routine]{
        var temp = tree
        
        for i in temp.indices{
            temp[i] = appendRecurse(src: temp[i], element: element, targetId: targetId)
        }
        
        return temp
    }
    
    private func appendRecurse(src:Routine, element:Routine, targetId:RoutineId) -> Routine{
        var temp = src
        if(temp.id == targetId){
            temp.tasks.append(element)
            return temp
        }
        
        for i in temp.tasks.indices{
            temp.tasks[i] = appendRecurse(src: src.tasks[i], element: element, targetId: targetId)
        }
        
        return temp
    }
    
    func deleteRoutineFromTree(tree:Tree, delete:Routine, all:Bool = false) -> Tree{
        var temp = tree
        
        if(temp.tasks.contains(where: {r in r.id == delete.id})){
            let child = temp.tasks.first(where: {r in r.id == delete.id})!.tasks
            let index = temp.tasks.firstIndex(where: {r in r.id == delete.id})!
            temp.tasks.remove(at: index)
            if(all == false){
                temp.tasks.append(contentsOf: child)
            }
        } else {
            for i in temp.tasks.indices{
                temp.tasks[i] = deleteRoutineFromRoutine(routine: temp.tasks[i], delete: delete, all: all)
            }
        }
        
        return temp
    }
    
    private func deleteRoutineFromRoutine(routine:Routine, delete:Routine, all:Bool) -> Routine{
        var temp = routine
        if(temp.tasks.contains(where: {r in r.id == delete.id})){
            // 対象のRoutineの子に削除対象が含まれていた場合
            let child = temp.tasks.first(where: {r in r.id == delete.id})!.tasks
            let index = temp.tasks.firstIndex(where: {r in r.id == delete.id})!
            temp.tasks.remove(at: index)
            if(all == false){
                temp.tasks.append(contentsOf: child)
            }
        } else {
            for i in temp.tasks.indices {
                temp.tasks[i] = deleteRoutineFromRoutine(routine: temp.tasks[i], delete: delete, all: all)
            }
        }
        return temp
    }
    
    
}
