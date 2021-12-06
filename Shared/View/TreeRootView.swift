//
//  TaskTreeRootView.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/20.
//

import SwiftUI

struct TreeRootView<Root:View, Node:View>: View {
    
    @Binding var routine:Tree
    let node:(Binding<Routine>) -> Node
    let root:(Binding<Tree>) -> Root
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            // Singletonなコレクション（PreferenceKey）にViewの中心座標を登録する
            root($routine)
                .id(RoutineId.createStartTaskId())
                .anchorPreference(
                    key: CollectDict.self,
                    value: .center,
                    transform: {center in
                        [RoutineId.createStartTaskId(): center]
                })
            HStack(alignment: .top, spacing: 0){
                ForEach(self.$routine.tasks, id:\.id){t in
                    TreeNodeView(task: t, node: self.node)
                }
            }
        }
        .backgroundPreferenceValue(CollectDict.self, {(centers:[RoutineId:Anchor<CGPoint>]) in
            GeometryReader{g in
                ForEach(self.routine.tasks.indices, id: \.self, content:{index in
                    let child = self.routine.tasks[index]
                    // taskの中心位置をSingletonなコレクションから取得
                    if let taskStartCenter = centers[RoutineId.createStartTaskId()] {
                        let start = g[taskStartCenter]
                        // childの中心位置をSingletonなコレクションから取得
                        if let taskEndCenter = centers[child.id] {
                            let end = g[taskEndCenter]
                            RightAngleLine(start: start, end: end).stroke()
                        }
                    }
                })
            }
        })
    }
}

struct TreeRootView_Previews: PreviewProvider {
    static var previews: some View {
        TreeRootView(
            routine: .constant(tutorialRoutine),
            node: {rt in
                Text(rt.wrappedValue.title)
                    .padding(8)
                
            },
            root: {r in Text(r.wrappedValue.preference.title)}
        )
    }
}
