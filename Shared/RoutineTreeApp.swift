//
//  RoutineTreeApp.swift
//  Shared
//
//  Created by Shun Yamazaki on 2021/11/06.
//

import SwiftUI

@main
struct RoutineTreeApp: App {
    var body: some Scene {
        WindowGroup {
            let routines:[Routine] = [
                .init(id: .init(id: .init()), title: "Routine1", tasks: .init()),
                .init(id: .init(id: .init()), title: "Routine2", tasks: .init())
            ]
            let routineDb = RoutineDatabase(routines: routines)
            let router = RoutineViewFactory()
            let vm = RoutineListViewModel(routineDb: routineDb)
            ContentView(vm: vm, router: router)
        }
    }
}

let taskViewFactory :TaskViewFactory = .init(plugins: [
    StartTaskViewGenerator(),
    SyncTaskViewGenerator(),
    TimeSpanTaskViewGenerator()
])
