//
//  SyncTaskNodeViewModel.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/11.
//

import Foundation
import Combine
protocol SyncTaskNodeViewModelDelegate{
    var isCompleted:Bool{get}
}
class SyncTaskNodeViewModel: SyncTaskNodeViewModelDelegate, ObservableObject{
    @Published public var isCompleted: Bool = false
    @Published public var task:RoutineTask
    
    private let playStore:PlayStore
    private let taskId:TaskId
    private let taskDatabase:TaskDatabaseDelegate
    private var subscription:Set<AnyCancellable> = .init()
    
    init(id:TaskId,
         ps:PlayStore,
         db:TaskDatabaseDelegate){
        self.playStore = ps
        self.taskId = id
        self.taskDatabase = db
        self.task = taskDatabase.getTask(id: taskId)!
        
        self.playStore.$taskCompletion.sink(receiveValue: {v in
            self.isCompleted = self.playStore.taskCompletion.contains(self.taskId)
        }).store(in: &subscription)
    }
    
    public func toggleComplete() -> Void{
        self.playStore.markAsComplete(id: self.taskId)
    }
    
    public func updateTitle(_ title:String) -> Void{
        let task = self.taskDatabase.getTask(id: self.taskId)!
        let newTask = task.editTitle(title)
        self.taskDatabase.updateTask(newTask)
        
        self.task = newTask
    }
    
    public func updateDescription(_ description:String) -> Void{
        let task = self.taskDatabase.getTask(id: self.taskId)!
        let newTask = task.editDescription(description)
        self.taskDatabase.updateTask(newTask)
        
        self.task = newTask
    }
}


