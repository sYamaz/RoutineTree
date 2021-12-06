//
//  RoutineTask.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/06.
//

import Foundation
struct Routine: Hashable, Identifiable, Codable{
    /// このタスクを識別するためのID
    public let id:RoutineId
    /// このタスクのタイプ
    public var type:TaskType
    /// タイトルまたはタスク名
    public var title:String
    /// このタスクの詳細な説明
    public var description:String
    /// このタスクに関するその他の情報
    public var properties:Dictionary<String, String>
    
    public var tasks:[Routine]
    

    public func makePlayable() -> PlayableRoutine{
        let cs = self.tasks.map{ch in ch.makePlayable()}
        
        return .init(id: self.id, type: self.type, title: self.title, description: self.description, properties: self.properties, children: cs, doing: .None, lastStartAt: nil)
    }
}



enum PlayState: Codable{
    case None
    case Doing
    case Done
}
