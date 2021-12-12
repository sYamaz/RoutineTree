//
//  RoutineTreeApp.swift
//  Shared
//
//  Created by Shun Yamazaki on 2021/11/06.
//

import SwiftUI

@main
struct RoutineTreeApp: App {
    @State var routines:[Tree] = [tutorialRoutine]
    @State var routineId:TreeId = tutorialRoutine.id

    var body: some Scene {
        WindowGroup {
            ContentView(trees: $routines,
                        treeId: $routineId)
                .onAppear(perform: {
                    routines = load(key: "routines") ?? [tutorialRoutine]
                    routineId = load(key: "routineId") ?? tutorialRoutine.id
                })
                .onChange(of: routineId, perform: {id in
                    save(key: "routineId", obj: id)
                })
                .onChange(of: routines, perform: {rs in
                    save(key: "routines", obj: rs)
                })
        }
        
    }
    
    private func save<T:Codable>(key:String, obj:T) -> Void{
        let enc = JSONEncoder()
        guard let data = try? enc.encode(obj) else{
            return
        }
        UserDefaults.standard.set(data, forKey: key)
    }

    private func load<T:Codable>(key:String) -> T?{
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return nil
        }
        let dec = JSONDecoder()
        guard let ret = try? dec.decode(T.self, from: data) else{
            return nil
        }

        return ret
    }
}

let tutorialRoutine:Tree = .init(id: .init(id: .init()), preference: .init(title: "Tutorial"), tasks: [
    .init(id: .init(id: .init()), type: .Sync, title: "About RoutineTree", description: "RoutineTree is a task management application that helps you accomplish your daily routine tasks.", properties: .init(), tasks: [
        .init(id: .init(id: .init()), type: .Sync, title: "Features", description: "The RoutineTree will help you to be strongly aware of the order in which tasks are executed. For example, \"Turn on the air conditioner in your room before doing the next task\".", properties: .init(), tasks: [
            .init(id: .init(id: .init()), type: .Sync, title: "Tree", description: "Tasks that do not have priority in the order can be defined by branching the Tree.", properties: .init(), tasks: .init()),
            .init(id: .init(id: .init()), type: .Sync, title: "Starting a routine", description: "To start a routine, select the routine in the area at the bottom of the screen and tap the Start button.", properties: .init(), tasks: [
            ])
        ])
    ])
    
])
