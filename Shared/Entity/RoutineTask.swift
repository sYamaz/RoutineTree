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
    
    public var doing:PlayState
    public var lastStartAt:Date?
    
    private init(id:TaskId,
                 type:TaskType,
                 title:String,
                 description:String,
                 properties:Dictionary<String,String>,
                 children:[RoutineTask],
                 doing:PlayState,
                 lastStartAt:Date){
        self.id = id
        self.type = type
        self.title = title
        self.description = description
        self.properties = properties
        self.children = children
        self.doing = doing
        self.lastStartAt = lastStartAt
    }

    
    public mutating func visit() -> Void{
        self.doing = .Doing
        self.lastStartAt = Date()
    }
    
    public mutating func markAsDone() -> Void{
        self.doing = .Done
        for i in children.indices{
            self.children[i].visit()
        }
    }
    
    public func allDone() -> Bool{
        if(self.doing != .Done){
            return false
        }
        
        for i in children.indices {
            if(children[i].allDone() == false){
                return false
            }
        }
        
        return true
    }
    
    public mutating func forceFinished() -> Void{
        self.doing = .None
        
        for i in children.indices{
            self.children[i].forceFinished()
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
    init(id:TaskId,
         type:TaskType,
         title:String,
         description:String,
         properties:Dictionary<String,String>,
         children:[RoutineTask]){
        self.id = id
        self.type = type
        self.title = title
        self.description = description
        self.properties = properties
        self.children = children
        self.doing = .None
        self.lastStartAt = nil
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

enum PlayState{
    case None
    case Doing
    case Done
}
