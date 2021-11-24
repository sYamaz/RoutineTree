//
//  Routine.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/06.
//

import Foundation
import SwiftUI


struct Routine: Identifiable, TaskAppendable{
    public let id: RoutineId
    public var title:String
    public var tasks:[RoutineTask]
    init(id:RoutineId, title:String, tasks:[RoutineTask]){
        self.id = id
        self.title = title
        self.tasks = tasks
    }
    
    public mutating func start() -> Void{
        for i in tasks.indices{
            tasks[i].visit()
        }
    }
    
    public func allDone() -> Bool{
        for i in tasks.indices{
            if(tasks[i].allDone() == false){
                return false
            }
        }
        
        return true
    }
    
    public mutating func forceFinished() -> Void{
        for i in tasks.indices{
            tasks[i].forceFinished()
        }
    }
    
    public mutating func append(_ task:RoutineTask) -> Void{
        self.tasks.append(task)
    }
}
