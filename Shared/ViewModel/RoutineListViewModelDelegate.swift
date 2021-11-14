//
//  RoutineListViewModelDelegate.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/06.
//

import Foundation
protocol RoutineListViewModelDelegate: ObservableObject{
    var routines:[Routine] { get }
    func delete(_ routineId:RoutineId) -> Void
    func add() -> Routine
    func moveTo(routine:Routine) -> Void
    
}

class RoutineListViewModelPreview : RoutineListViewModelDelegate{

    
    @Published var routines: [Routine]
    
    init(_ routines:[Routine]){
        self.routines = routines
    }
    
    func delete(_ routineId:RoutineId) -> Void{
        
    }
    
    func add() -> Routine {
        let new = Routine(id: .init(id: .init()), title: "New Routine", taskIds: .init())
        
        self.routines.append(new)
        
        return new
    }
    
    func moveTo(routine:Routine) -> Void{
        
    }
}
