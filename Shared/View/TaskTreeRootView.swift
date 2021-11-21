//
//  TaskTreeRootView.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/20.
//

import SwiftUI

struct TaskTreeRootView<VM:RoutineViewModelDelegate & ObservableObject,Root:View, Node:View>: View {
    @ObservedObject var vm:VM
    let node:(RoutineTask) -> Node
    let root:(Routine) -> Root
    let task:RoutineTask = .init(id: .createStartTaskId(), type: .Start, title: "Start", description: "Description", properties: .init(), children: .init())
    var body: some View {
        VStack(alignment: .leading, spacing: nil){
            // Singletonなコレクション（PreferenceKey）にViewの中心座標を登録する
            root(vm.routine)
                .anchorPreference(
                    key: CollectDict.self,
                    value: .center,
                    transform: {center in
                        [TaskId.createStartTaskId(): center]
                })
            HStack(alignment: .top, spacing: nil){
                ForEach(vm.routine.tasks, id: \.id){
                    TaskTreeView(task: $0, node: self.node)
                }
            }
        }
        .backgroundPreferenceValue(CollectDict.self, {(centers:[TaskId:Anchor<CGPoint>]) in
            GeometryReader{g in
                ForEach(self.vm.routine.tasks, id: \.id, content:{child in
                    // taskの中心位置をSingletonなコレクションから取得
                    if let taskStartCenter = centers[self.task.id] {
                        let start = g[taskStartCenter]
                        // childの中心位置をSingletonなコレクションから取得
                        if let taskEndCenter = centers[child.id] {
                            let end = g[taskEndCenter]
                            Line(start: start, end: end).stroke()
                        }
                    }
                })
            }
        })
    }
}

struct TaskTreeRootView_Previews: PreviewProvider {
    static var previews: some View {
        let vm:RoutineViewModel = .init(routine: previewRoutine)
        
        TaskTreeRootView(
            vm:vm ,
            node: {rt in Text(rt.title).modifier(RoundedRectangleStyle())},
            root: {r in Text(r.title).modifier(DashRoundedRectangleStyle())
            
        })
    }
}
