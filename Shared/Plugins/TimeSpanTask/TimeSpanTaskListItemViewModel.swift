//
//  TimeSpanTaskListItemViewModel.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/12.
//

import Foundation
class TimeSpanTaskListItemViewModel: ObservableObject{
    @Published var title:String = ""
    @Published var description:String = ""
    @Published var minutes:Int
    @Published var seconds:Int
    @Published var progress:Double
    
    private let taskId:TaskId
    private let taskDb:TaskDatabaseDelegate
    
    init(taskId: TaskId, taskDb:TaskDatabaseDelegate){
        self.taskId = taskId
        self.taskDb = taskDb
        
        if let t = taskDb.getTask(id: self.taskId){
            self.title = t.title
            self.description = t.description
            self.minutes = Int(t.properties["minutes"]!)!
            self.seconds = Int(t.properties["seconds"]!)!
            
        } else {
            self.title = "unknown"
            self.description = "unknown"
            self.minutes = 1
            self.seconds = 0
        }
        
        self.progress = 0.3
    }
    
    public func update(title:String, description:String, minutes:Int, seconds:Int) -> Void{
        let t = self.taskDb.getTask(id: self.taskId)!
        let newT = t.editTitle(title)
                    .editDescription(description)
                    .editProperties(prop:"minutes", value: String(minutes))
                    .editProperties(prop:"seconds", value: String(seconds))
        self.taskDb.updateTask(newT)
        
        self.title = title
        self.description = description
        self.minutes = minutes
        self.seconds = seconds
    }
}
