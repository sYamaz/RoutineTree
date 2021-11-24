//
//  TaskTreeRootView.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/20.
//

import SwiftUI

struct TaskTreeRootView<Root:View, Node:View>: View {
    
    @Binding var routine:Routine
    let node:(Binding<RoutineTask>) -> Node
    let root:(Binding<Routine>) -> Root
    
    var body: some View {
        VStack(alignment: .leading, spacing: nil){
            // Singletonなコレクション（PreferenceKey）にViewの中心座標を登録する
            root($routine)
                .id(TaskId.createStartTaskId())
                .anchorPreference(
                    key: CollectDict.self,
                    value: .center,
                    transform: {center in
                        [TaskId.createStartTaskId(): center]
                })
            HStack(alignment: .top, spacing: nil){
                ForEach(self.routine.tasks.indices, id: \.self){index in
                    let t = self.$routine.tasks[index]
                    TaskTreeView(task: t, node: self.node)
                }
            }
        }
        .backgroundPreferenceValue(CollectDict.self, {(centers:[TaskId:Anchor<CGPoint>]) in
            GeometryReader{g in
                ForEach(self.routine.tasks.indices, id: \.self, content:{index in
                    let child = self.routine.tasks[index]
                    // taskの中心位置をSingletonなコレクションから取得
                    if let taskStartCenter = centers[TaskId.createStartTaskId()] {
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
        TaskTreeRootView(
            routine: .constant(previewRoutine),
            node: {rt in Text(rt.wrappedValue.title).modifier(RoundedRectangleStyle(focused: false))},
            root: {r in Text(r.wrappedValue.title).modifier(DashRoundedRectangleStyle())
            
        })
    }
}
