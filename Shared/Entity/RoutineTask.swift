//
//  RoutineTask.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/06.
//

import Foundation
protocol TaskAppendable{
    mutating func append(_ newTask:RoutineTask) -> Void
}
    
struct RoutineTask: Identifiable, TaskAppendable{
    /// このタスクを識別するためのID
    public let id:TaskId
    /// このタスクのタイプ
    public let type:TaskType
    /// タイトルまたはタスク名
    public var title:String
    /// このタスクの詳細な説明
    public var description:String
    /// このタスクに関するその他の情報
    public var properties:Dictionary<String, String>
    
    public var children:[RoutineTask]
    
    private(set) var doing:Bool = false
    
    public var editing:Bool
    
    init(id:TaskId, type:TaskType, title:String, description:String, properties:Dictionary<String,String>, children:[RoutineTask]){
        self.id = id
        self.type = type
        self.title = title
        self.description = description
        self.properties = properties
        self.children = children
        self.editing = false
    }

    
    public mutating func visit() -> Void{
        self.doing = true
    }
    
    public mutating func markAsDone() -> Void{
        self.doing = false
        for var t in children{
            t.visit()
        }
    }
    
    public mutating func forceFinished() -> Void{
        self.doing = false
        for var t in children{
            t.forceFinished()
        }
    }
    
    public mutating func append(_ newTask:RoutineTask) -> Void{
        self.children.append(newTask)
    }
    
    public mutating func deleteChild(_ id:TaskId) -> Void{
        self.children.removeAll(where: {t in t.id == id})
    }
}

extension RoutineTask{
    
    func getMinutes() -> Int{
        return Int( self.properties["minutes"]! )!
    }
    
    mutating func setMinutes(_ val:Int) -> Void{
        self.properties["minutes"] = String(val)
    }
    
    func getSeconds() -> Int{
        return Int(self.properties["seconds"]!)!
    }
    
    mutating func setSeconds(_ val:Int) -> Void{
        self.properties["seconds"] = String(val)
    }
}
