//
//  TimeSpanTaskListItemViewModel.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/12.
//

import Foundation
class TimeSpanTaskListItemViewModel: ObservableObject{

    @Published var task:RoutineTask
    
    init(task: RoutineTask){
        self.task = task
    }
    
    public func updateTitle(_ title:String) -> Void{
        self.task.title = title
    }
    
    public func updateDescription(_ description:String) -> Void{
        self.task.description = description
    }
    
    public func updateMinutes(_ minutes:Int) -> Void{
        self.task.setMinutes(minutes)
    }
    
    public func updateSeconds(_ seconds:Int) -> Void{
        self.task.setSeconds(seconds)
    }

    func markAsDone() -> Void{

    }
}
