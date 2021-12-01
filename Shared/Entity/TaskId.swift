//
//  TaskId.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/06.
//

import Foundation
struct TaskId: Hashable, Codable{
    let id:String
    
    public init(id: UUID){
        self.id = id.uuidString
    }
    
    private init(id: String){
        self.id = id
    }
}


extension TaskId{
    public static func createAddNewTaskId() -> Self{
        return .init(id: "addnew")
    }
    
    public func isAddNewTaskId() -> Bool{
        return self.id == "addnew"
    }
}

extension TaskId{
    public static func createStartTaskId() -> Self{
        return .init(id: "start")
    }
    
    public func isStartTaskId() -> Bool{
        return self.id == "start"
    }
}

extension TaskId{
    public static func createUndeterminedId() -> Self{
        return .init(id: "undetermined")
    }
    
    public func isUndeterminedId() -> Bool{
        return self.id == "undetermined"
    }
}
