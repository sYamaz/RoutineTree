//
//  Routine.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/06.
//

import Foundation
import Combine
import SwiftUI


class Routine: ObservableObject, Identifiable, TaskAppendable{
    public let id: RoutineId
    @Published public var title:String
    @Published public var tasks:[RoutineTask]
    
    private var subscription:Set<AnyCancellable> = .init()
    init(id:RoutineId, title:String, tasks:[RoutineTask]){
        self.id = id
        self.title = title
        self.tasks = tasks
    }
    
    public func start() -> Void{
        for t in tasks{
            t.visit()
        }
    }
    
    public func forceFinished() -> Void{
        for t in tasks{
            t.forceFinished()
        }
    }
    
    public func append(_ task:RoutineTask) -> Void{
        self.tasks.append(task)
        print(tasks)
    }
}
