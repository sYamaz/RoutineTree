//
//  RoutineListViewModel.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/06.
//

import Foundation
import Combine
class RoutineListViewModel: RoutineListViewModelDelegate{
    @Published var routines:[Routine] = [Routine]()
    private var subscriptions:Set<AnyCancellable> = .init()
    private let routineDb:RoutineDatabaseDelegate
    
    init(routineDb:RoutineDatabase){
        self.routineDb = routineDb
        routineDb.onReceive(closure: {v in self.routines = v})
    }
    
    public func delete(_ routineId:RoutineId) -> Void{
        self.routineDb.deleteRoutine(id: routineId)
    }
    
    func add() -> Routine {
        let newId = self.routineDb.addRoutine()
        return self.routineDb.getRoutine(id: newId)!
    }
}
