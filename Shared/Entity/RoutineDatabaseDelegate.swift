//
//  RoutineDatabaseDelegate.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/06.
//

import Foundation
import Combine
protocol RoutineDatabaseDelegate{
    /// 新たなルーティンを追加します
    /// - Returns: 新規作成されたルーティンのID
    func addRoutine() -> RoutineId
    
    /// ルーティンを取得します
    /// - Returns: ルーティン
    func getRoutine(id: RoutineId) -> Routine?
    
    /// ルーティンを更新します
    /// - Returns: Void
    func updateRoutine(_ routine:Routine) -> Void
    
    /// ルーティンを削除します
    /// - Returns: Void
    func deleteRoutine(id:RoutineId) -> Void
    
    func onReceive(closure: @escaping ([Routine]) -> Void) -> Void
}

class RoutineDatabase: RoutineDatabaseDelegate, ObservableObject{

    
    @Published private var routines: [Routine]
    private var subscriptions:Set<AnyCancellable> = .init()
    
    init(){
        self.routines = .init()
    }
    
    init(routines:[Routine]){
        self.routines = routines
    }
    
    func addRoutine() -> RoutineId {
        let newOne:Routine = .init(id: .init(id: .init()), title: "New routine", taskIds: .init())
        routines.append(newOne)
        return newOne.id
    }
    
    func getRoutine(id: RoutineId) -> Routine? {
        for routine in routines {
            if(routine.id == id){
                return routine
            }
        }
        return nil
    }
    
    func updateRoutine(_ routine: Routine) -> Void {
        if let idx = routines.firstIndex(where: {r in r.id == routine.id}){
            self.routines[idx] = routine
        }
    }
    
    func deleteRoutine(id: RoutineId) -> Void {
        if let idx = routines.firstIndex(where: {r in r.id == id}){
            self.routines.remove(at: idx)
        }
    }
    
    func onReceive(closure: @escaping ([Routine]) -> Void) {
        self.$routines.sink(receiveValue: closure).store(in: &self.subscriptions)
    }
}
