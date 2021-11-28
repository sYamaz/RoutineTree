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
            let routines:[RoutineTree] = [
                tutorialRoutine,
            ]
            let routineDb = RoutineDatabase(routines: routines)
            let router = RoutineViewFactory()
            let vm = RoutineListViewModel(routineDb: routineDb)
            ContentView(vm: vm, router: router)
        }
    }
}

let tutorialRoutine:RoutineTree = .init(id: .init(id: .init()), title: "Tutorial", tasks: [
    .init(id: .init(id: .init()), type: .Sync, title: "RoutineTreeについて", description: "RoutineTreeはあなたの日々のルーチンの達成を補助するタスク管理アプリです", properties: .init(), children: [
        .init(id: .init(id: .init()), type: .Sync, title: "RoutineTreeの特徴", description: "RoutineTreeを使うことでタスクの実行順について強く意識することができるようになります。\n例えばタイマーをセットしてから次のタスクをする。あなたの部屋のエアコンをつけてから次のタスクをするなどです。", properties: .init(), children: [
            .init(id: .init(id: .init()), type: .Sync, title: "サポートしているタスクの種類", description: "RoutineTreeでサポートしているタスクの種類について説明します", properties: .init(), children: [
                .init(id: .init(id: .init()), type: .Sync, title: "シンプルなタスク", description: "タスクの開始/完了をあなたが完全にコントロールできるタスクです。例えばコーヒーを飲む、腕立て伏せを30回行うなどです。", properties: .init(), children: [
                ]),
                .init(id: .init(id: .init()), type: .TimeSpan, title: "時間経過を待つタスク", description: "一定時間経過するまで完了できないタスクです。例えば電子レンジで3分間温める、2分間スクワットを続けるなどです。", properties: ["minutes":"2", "seconds":"10"], children: [
                ])
            ]),
            .init(id: .init(id: .init()), type: .Sync, title: "ルーチンの開始", description: "ルーチンを開始するには、画面下のボタンをタップします。タスクが完了した時はDoneボタンをタップしてください。", properties: .init(), children: [
            ])
        ])
    ])

])

func makeStarted(routine:RoutineTree) -> RoutineTree{
    var r = routine
    r.start()
    return r
}

let taskViewFactory :TaskViewFactory = .init(plugins: [
    SyncTaskViewGenerator(),
    TimeSpanTaskViewGenerator()
])
