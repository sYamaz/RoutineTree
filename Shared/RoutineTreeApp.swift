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
                .init(id: .init(id: .init()), title: "Routine1", taskIds: .init()),
                .init(id: .init(id: .init()), title: "Routine2", taskIds: .init())
            ]
            let routineDb = RoutineDatabase(routines: routines)
            let taskDb = TaskDatabase(tasks: .init())
            let playStore = PlayStore()
            let plugins:[TaskTypeGeneratorDelegate] = [
                SyncTaskViewGenerator(ps: playStore, db: taskDb),
                TimeSpanTaskViewGenerator(db: taskDb)
            ]
            let templateGenerator = TaskTemplateGenerator(plugins: plugins)
            let router = ContentRouter(routineDb: routineDb, taskDb: taskDb, generator: templateGenerator)
            let vm = ContentViewModel(router: router)
            ContentView(vm: vm, router: router)
        }
    }
}
