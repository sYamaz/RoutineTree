//
//  RoutineViewModel.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/10.
//

import Foundation
import Combine

protocol RoutineViewModelDelegate{
    var routine:RoutineTree{get set}
    /// ルーティンのタイトルを更新する
    /// - Returns: Void
    func updateTitle(_ title:String) -> Void
    
    /// ルーティンを開始する
    /// - Returns: Void
    func play() -> Void
    /// タスクを完了ずみにマークする
    /// - Returns: Void
    func quit() -> Void
    
    func updateRoutine(_ r:RoutineTree) -> Void
}


class RoutineViewModel: RoutineViewModelDelegate, ObservableObject{

    
    private var subscriptions:Set<AnyCancellable> = .init()
    @Published var routine:RoutineTree
    
    init(routine:RoutineTree){
        self.routine = routine
        
        self.$routine.sink(receiveValue: {r in print("RoutineViewModel: routine udpated.")}).store(in: &subscriptions)
    }
    func updateTitle(_ title: String) -> Void {
        self.routine.title = title
    }
    
    func updateRoutine(_ r:RoutineTree) -> Void{
        self.routine = r
    }
    
    func play() {
        routine.start()
    }
    
    func quit() {
        routine.forceFinished()
    }
}
