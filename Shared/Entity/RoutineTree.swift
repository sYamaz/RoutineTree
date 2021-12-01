//
//  Routine.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/06.
//

import Foundation
import SwiftUI


struct RoutineTree: Hashable, Identifiable, TaskAppendable{
    static func == (lhs: RoutineTree, rhs: RoutineTree) -> Bool {
        return (lhs.id.id == rhs.id.id)
        && (lhs.title == rhs.title)
        && (lhs.tasks == rhs.tasks)
    }
    
    public let id: RoutineId
    public var title:String
    public var tasks:[RoutineTask]
    init(id:RoutineId, title:String, tasks:[RoutineTask]){
        self.id = id
        self.title = title
        self.tasks = tasks
    }
    
    public func makePlayable() -> PlayableRoutineTree{
        let cs = self.tasks.map{t in t.makePlayable()}
        let ret = PlayableRoutineTree(id: self.id, title: self.title, tasks: cs)
        return ret
    }

    
    public mutating func append(_ task:RoutineTask) -> Void{
        self.tasks.append(task)
    }
}
