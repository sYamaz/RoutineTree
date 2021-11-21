//
//  SyncTaskListItemViewModel.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/12.
//

import Foundation
class SyncTaskListItemViewModel: ObservableObject{
    @Published var task:RoutineTask
    
    init(task: RoutineTask){
        self.task = task
    }
    
    func updateTitle(title:String) -> Void{
        self.task.title = title
    }
    
    func updateDescription(description:String) -> Void{
        self.task.description = description
    }
    
    func markAsDone() -> Void{

    }
}
