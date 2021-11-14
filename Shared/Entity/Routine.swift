//
//  Routine.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/06.
//

import Foundation

struct Routine: Identifiable{
    public let id: RoutineId
    public let title:String
    public let taskIds:[TaskId]
}

extension Routine{
    public func editTitle(_ title:String) -> Self{
        .init(id: self.id, title: title, taskIds: self.taskIds)
    }
    
    public func append(_ taskId:TaskId) -> Self{
        var new = self.taskIds
        if(new.contains(taskId)){
            return self
        }
        
        new.append(taskId)
        return .init(id: self.id, title:self.title, taskIds: new)
    }
    
    public func remove(_ taskId:TaskId) -> Self{
        var new = self.taskIds
        if(new.contains(taskId)){
            new.removeAll(where: {t in t.id == taskId.id})
            return .init(id: self.id, title: self.title, taskIds: new)
        }
        
        return self;
    }
}
