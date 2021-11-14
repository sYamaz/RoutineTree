//
//  SyncTaskListItemViewModel.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/12.
//

import Foundation
class SyncTaskListItemViewModel: ObservableObject{
    @Published var title:String = ""
    @Published var description:String = ""
    
    private let taskId:TaskId
    private let taskDb:TaskDatabaseDelegate
    
    init(taskId: TaskId, taskDb:TaskDatabaseDelegate){
        self.taskId = taskId
        self.taskDb = taskDb
        
        if let t = taskDb.getTask(id: self.taskId){
            self.title = t.title
            self.description = t.description
            
        } else {
            self.title = "unknown"
            self.description = "unknown"
        }
    }
    
    func update(editingTitle:String, editingDescription:String) -> Void{
        let t = self.taskDb.getTask(id: self.taskId)!
        let newT = t.editTitle(self.title).editDescription(self.description)
        self.taskDb.updateTask(newT)
        
        self.title = editingTitle
        self.description = editingDescription
    }
}
