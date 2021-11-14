//
//  RoutineTask.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/06.
//

import Foundation
struct RoutineTask: Identifiable{
    /// このタスクを識別するためのID
    public let id:TaskId
    /// このタスクのタイプ
    public let type:TaskType
    /// タイトルまたはタスク名
    public let title:String
    /// このタスクの詳細な説明
    public let description:String
    /// このタスクの直前のタスク
    public let followingTaskId:TaskId
    /// このタスクに関するその他の情報
    public let properties:Dictionary<String, String>
}

extension RoutineTask{
    /// タイトルを編集したインスタンスを生成します
    /// - Parameter new: 新しいタイトル
    /// - Returns: 新たなRoutineTaskインスタンス
    public func editTitle(_ new:String) -> Self{
        return .init(id: self.id, type:self.type, title: new, description: self.description, followingTaskId: self.followingTaskId, properties: self.properties)
    }
    
    /// 説明文を編集したインスタンスを生成します
    /// - Parameter new: 新しい説明文
    /// - Returns: 新たなRoutineTaskインスタンス
    public func editDescription(_ new:String) -> Self{
        return .init(id: self.id, type:self.type, title: self.title, description: new, followingTaskId: self.followingTaskId, properties: self.properties)
    }
    
    /// 後続タスクを変更したインスタンスを生成します
    /// - Parameter new: 新たな先行タスク
    /// - Returns: 新たなインスタンス
    public func editFollowingTaskId(_ new:TaskId) -> Self{
        return .init(id: self.id, type:self.type, title: self.title, description: self.description, followingTaskId: new, properties: self.properties)
    }
    
    /// プロパティを変更したインスタンスを生成します
    /// - Parameter new: 新たなプロパティ
    /// - Returns: 新たなインスタンス
    public func editProperties(prop:String, value:String) -> Self{
        var p = self.properties
        p[prop] = value
        
        return .init(id: self.id, type:self.type, title: self.title, description: self.description, followingTaskId: self.followingTaskId, properties: p)
    }
}
