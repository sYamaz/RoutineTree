//
//  TaskDatabaseDelegate.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/09.
//

import Foundation
import Combine
protocol TaskDatabaseDelegate{
    /// 新たなタスクを追加します
    /// - Returns: 新規作成されたタスクのID
    func addTask() -> TaskId
    
    /// タスクを取得します
    /// - Returns: タスク
    func getTask(id: TaskId) -> RoutineTask?
    
    /// タスクを更新します
    /// - Returns: Void
    func updateTask(_ task:RoutineTask) -> Void
    
    /// タスクを削除します
    /// - Returns: Void
    func deleteTask(id: TaskId) -> Void
}

class TaskDatabase:TaskDatabaseDelegate, ObservableObject{
    private var tasks:[RoutineTask]
    
    init(tasks:[RoutineTask]){
        self.tasks = tasks
    }
    
    func addTask() -> TaskId {
        let newTask = RoutineTask(id: .init(id: .init()), type: .Sync, title: "New task", description: "description", followingTaskId: .createUndeterminedId(), properties: .init())
        
        self.tasks.append(newTask)
        
        return newTask.id
    }
    
    func getTask(id: TaskId) -> RoutineTask? {
        for task in tasks {
            if (task.id == id){
                return task
            }
        }
        return nil
    }
    
    func updateTask(_ task: RoutineTask) {
        if let idx = tasks.firstIndex(where: {t in t.id == task.id}){
            tasks[idx] = task
        }
    }
    
    func deleteTask(id: TaskId) {
        if let idx = tasks.firstIndex(where: {t in t.id == id}){
            tasks.remove(at: idx)
        }
    }
    
    
}
