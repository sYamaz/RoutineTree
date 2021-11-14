//
//  ContentRouter.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/06.
//

import Foundation
import SwiftUI
class ContentRouter: ContentWireframe{
    @Published var viewToShow: AnyView
    
    let routineDb:RoutineDatabase
    let taskDb:TaskDatabase
    let generator:TaskTemplateGeneratorDelegate
    init(routineDb:RoutineDatabase,
         taskDb:TaskDatabase,
         generator:TaskTemplateGeneratorDelegate){
        self.routineDb = routineDb
        self.taskDb = taskDb
        self.generator = generator
        self.viewToShow = AnyView(Text("EmptyState"))
    }
    
    func navigateToRoutineListView() -> Void{
        self.viewToShow =
        AnyView(RoutineListView(vm: RoutineListViewModel(routineDb: routineDb, navigator: self)))
    }
    
    func navigateToRoutineView(routine: Routine) -> Void{
        self.viewToShow = AnyView(
            RoutineView(vm: RoutineViewModel(routineId: routine.id, routineDb: routineDb, taskDb: taskDb, generator: generator))
        )
    }
}
