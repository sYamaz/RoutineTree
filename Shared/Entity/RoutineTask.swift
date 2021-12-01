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


struct RoutineTask: Hashable, Identifiable, TaskAppendable{
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
    }

    public func makePlayable() -> PlayableRoutineTask{
        let cs = self.children.map{ch in ch.makePlayable()}
        
        return .init(id: self.id, type: self.type, title: self.title, description: self.description, properties: self.properties, children: cs, doing: .None, lastStartAt: nil)
    }

    public mutating func append(_ newTask:RoutineTask) -> Void{
        self.children.append(newTask)
    }
}



enum PlayState: Codable{
    case None
    case Doing
    case Done
}
