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
    func getRoutine(id: RoutineId) -> RoutineTree?
    
    /// ルーティンを更新します
    /// - Returns: Void
    func updateRoutine(_ routine:RoutineTree) -> Void
    
    /// ルーティンを削除します
    /// - Returns: Void
    func deleteRoutine(id:RoutineId) -> Void
    
    func onReceive(closure: @escaping ([RoutineTree]) -> Void) -> Void
}

class RoutineDatabase: RoutineDatabaseDelegate, ObservableObject{

    static func previewInstance() -> RoutineDatabase{
        return .init(routines: [
            .init(id: .init(id: .init()), title: "Routine1", tasks: .init()),
            .init(id: .init(id: .init()), title: "Routine2", tasks: .init())
        ])
    }
    
    @Published private var routines: [RoutineTree]
    private var subscriptions:Set<AnyCancellable> = .init()
    
    init(){
        self.routines = .init()
    }
    
    init(routines:[RoutineTree]){
        self.routines = routines
    }
    
    func addRoutine() -> RoutineId {
        let newOne:RoutineTree = .init(id: .init(id: .init()), title: "New routine", tasks: .init())
        routines.append(newOne)
        return newOne.id
    }
    
    func getRoutine(id: RoutineId) -> RoutineTree? {
        for routine in routines {
            if(routine.id == id){
                return routine
            }
        }
        return nil
    }
    
    func updateRoutine(_ routine: RoutineTree) -> Void {
        if let idx = routines.firstIndex(where: {r in r.id == routine.id}){
            self.routines[idx] = routine
        }
    }
    
    func deleteRoutine(id: RoutineId) -> Void {
        if let idx = routines.firstIndex(where: {r in r.id == id}){
            self.routines.remove(at: idx)
        }
    }
    
    func onReceive(closure: @escaping ([RoutineTree]) -> Void) {
        self.$routines.sink(receiveValue: closure).store(in: &self.subscriptions)
    }
}
