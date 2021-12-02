//
//  RoutineTreeApp.swift
//  Shared
//
//  Created by Shun Yamazaki on 2021/11/06.
//

import SwiftUI

@main
struct RoutineTreeApp: App {
    @State var routines:[RoutineTree] = [tutorialRoutine]
    @State var routineId:RoutineId = tutorialRoutine.id
    let router = RoutineViewFactory()
    
    var body: some Scene {
        WindowGroup {
            ContentView(routines: $routines,
                        routineId: $routineId,
                        router: router)
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

let tutorialRoutine:RoutineTree = .init(id: .init(id: .init()), title: "Tutorial", tasks: [
    .init(id: .init(id: .init()), type: .Sync, title: "RoutineTreeについて", description: "RoutineTreeはあなたの日々のルーチンの達成を補助するタスク管理アプリです", properties: .init(), tasks: [
        .init(id: .init(id: .init()), type: .Sync, title: "RoutineTreeの特徴", description: "RoutineTreeを使うことでタスクの実行順について強く意識することができるようになります。\n例えばタイマーをセットしてから次のタスクをする。あなたの部屋のエアコンをつけてから次のタスクをするなどです。", properties: .init(), tasks: [
            .init(id: .init(id: .init()), type: .Sync, title: "サポートしているタスクの種類", description: "RoutineTreeでサポートしているタスクの種類について説明します", properties: .init(), tasks: [
                .init(id: .init(id: .init()), type: .Sync, title: "シンプルなタスク", description: "タスクの開始/完了をあなたが完全にコントロールできるタスクです。例えばコーヒーを飲む、腕立て伏せを30回行うなどです。", properties: .init(), tasks: [
                ]),
                .init(id: .init(id: .init()), type: .TimeSpan, title: "時間経過を待つタスク", description: "一定時間経過するまで完了できないタスクです。例えば電子レンジで3分間温める、2分間スクワットを続けるなどです。", properties: ["minutes":"2", "seconds":"10"], tasks: [
                ])
            ]),
            .init(id: .init(id: .init()), type: .Sync, title: "ルーチンの開始", description: "ルーチンを開始するには、画面下のボタンをタップします。タスクが完了した時はDoneボタンをタップしてください。", properties: .init(), tasks: [
            ])
        ])
    ])
    
])

let taskViewFactory :TaskViewFactory = .init(plugins: [
    SyncTaskViewGenerator(),
    TimeSpanTaskViewGenerator()
])
