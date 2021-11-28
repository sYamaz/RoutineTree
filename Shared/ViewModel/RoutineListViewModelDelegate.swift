//
//  RoutineListViewModelDelegate.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/06.
//

import Foundation
protocol RoutineListViewModelDelegate: ObservableObject{
    var routines:[RoutineTree] { get }
    func delete(_ routineId:RoutineId) -> Void
    func add() -> RoutineTree
}

class RoutineListViewModelPreview : RoutineListViewModelDelegate{

    
    @Published var routines: [RoutineTree]
    
    init(_ routines:[RoutineTree]){
        self.routines = routines
    }
    
    func delete(_ routineId:RoutineId) -> Void{
        
    }
    
    func add() -> RoutineTree {
        let new = RoutineTree(id: .init(id: .init()), title: "New Routine", tasks: .init())
        
        self.routines.append(new)
        
        return new
    }
}
