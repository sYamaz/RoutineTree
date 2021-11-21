//
//  RoutineTask.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/06.
//

import Foundation
protocol TaskAppendable{
    func append(_ newTask:RoutineTask) -> Void
}
    
class RoutineTask: ObservableObject, Identifiable, TaskAppendable{
    /// このタスクを識別するためのID
    public let id:TaskId
    /// このタスクのタイプ
    public let type:TaskType
    /// タイトルまたはタスク名
    @Published public var title:String
    /// このタスクの詳細な説明
    @Published public var description:String
    /// このタスクに関するその他の情報
    @Published public var properties:Dictionary<String, String>
    
    @Published public var children:[RoutineTask]
    
    @Published private(set) var doing:Bool = false
    
    init(id:TaskId, type:TaskType, title:String, description:String, properties:Dictionary<String,String>, children:[RoutineTask]){
        self.id = id
        self.type = type
        self.title = title
        self.description = description
        self.properties = properties
        self.children = children
    }

    
    public func visit() -> Void{
        self.doing = true
    }
    
    public func markAsDone() -> Void{
        self.doing = false
        for t in children{
            t.visit()
        }
    }
    
    public func forceFinished() -> Void{
        self.doing = false
        for t in children{
            t.forceFinished()
        }
    }
    
    public func append(_ newTask:RoutineTask) -> Void{
        self.children.append(newTask)
        self.objectWillChange.send()
    }
    
    public func deleteChild(_ id:TaskId) -> Void{
        self.children.removeAll(where: {t in t.id == id})
        self.objectWillChange.send()
    }
}

extension RoutineTask{
    
    func getMinutes() -> Int{
        return Int( self.properties["minutes"]! )!
    }
    
    func setMinutes(_ val:Int) -> Void{
        self.properties["minutes"] = String(val)
    }
    
    func getSeconds() -> Int{
        return Int(self.properties["seconds"]!)!
    }
    
    func setSeconds(_ val:Int) -> Void{
        self.properties["seconds"] = String(val)
    }
}
