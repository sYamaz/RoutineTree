//
//  RoutineViewModel.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/10.
//

import Foundation
import Combine
import SwiftUI

protocol RoutineViewModelDelegate{
    var title:String{get}
    var taskIds:[TaskId]{get}
    func updateTitle(_ title:String) -> Void
    func getView(_ taskId:TaskId) -> AnyView
    func deleteTask(_ taskId: TaskId) -> Void
}

class RoutineViewModel: RoutineViewModelDelegate, ObservableObject{
    private let routineDb:RoutineDatabaseDelegate
    private let taskDb:TaskDatabaseDelegate
    private let routineId:RoutineId
    private let generator:TaskTemplateGeneratorDelegate
    private var subscriptions:Set<AnyCancellable> = .init()
    
    @Published var title:String
    @Published var taskIds:[TaskId]
    
    init(routineId:RoutineId,
         routineDb:RoutineDatabaseDelegate,
         taskDb:TaskDatabaseDelegate,
         generator:TaskTemplateGeneratorDelegate){
        self.routineId = routineId
        self.generator = generator
        self.routineDb = routineDb
        self.taskDb = taskDb
        self.title = ""
        self.taskIds = .init()
        
        self.routineDb.onReceive(closure: {routines in
            for routine in routines {
                if(routine.id == self.routineId){
                    self.title = routine.title
                    self.taskIds = routine.taskIds
                }
            }
        })
    }
    func updateTitle(_ title: String) -> Void {
        print(title)
        
        let routine = routineDb.getRoutine(id: self.routineId)!
        let newRoutine = routine.editTitle(title)
        routineDb.updateRoutine(newRoutine)
    }
    
    func deleteTask(_ taskId: TaskId) {
        let routine = routineDb.getRoutine(id: self.routineId)!
        let newRoutine = routine.remove(taskId)
        routineDb.updateRoutine(newRoutine)
        taskDb.deleteTask(id: taskId)
    }
    
    
    func getView(_ taskId:TaskId) -> AnyView{
        if let task = taskDb.getTask(id: taskId){
            return generator.generateView(task: task)
        }
        return AnyView(Text("Convert error"))
    }
}
