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

}


class RoutineViewModel: RoutineViewModelDelegate, ObservableObject{

    
    private var subscriptions:Set<AnyCancellable> = .init()
    @Published var routine:RoutineTree
    
    init(routine:RoutineTree){
        self.routine = routine
        
        self.$routine.sink(receiveValue: {r in print("RoutineViewModel: routine udpated.")}).store(in: &subscriptions)
    }

}
