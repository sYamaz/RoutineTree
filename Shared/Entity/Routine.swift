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
    
    public func start() -> Void{
        for var t in tasks{
            t.visit()
        }
    }
    
    public func forceFinished() -> Void{
        for var t in tasks{
            t.forceFinished()
        }
    }
    
    public mutating func append(_ task:RoutineTask) -> Void{
        self.tasks.append(task)
        print(tasks)
    }
}
