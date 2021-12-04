//
//  TaskNodeView.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/17.
//

import SwiftUI

struct TaskTreeView<Node:View>: View {
    @Binding var task:RoutineTask
    let node:(Binding<RoutineTask>) -> Node
    
    init(task:Binding<RoutineTask>, node:@escaping (Binding<RoutineTask>) -> Node){
        self._task = task
        self.node = node
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: nil){
            node(self.$task)
                .id($task.id)
                // Singletonなコレクション（PreferenceKey）にViewの中心座標を登録する
                .anchorPreference(key: CollectDict.self, value: .center, transform: {center in
                    [self.task.id: center]
                })
            HStack(alignment: .top, spacing: 4){
                ForEach($task.tasks, id: \.id){t in
                    TaskTreeView(task:  t, node: self.node)
                }
            }
            Spacer()
        }
        .backgroundPreferenceValue(CollectDict.self, {(centers:[TaskId:Anchor<CGPoint>]) in
            GeometryReader{g in
                ForEach(self.task.tasks, id: \.id, content:{child in
                    // taskの中心位置をSingletonなコレクションから取得
                    if let taskStartCenter = centers[self.task.id] {
                        let start = g[taskStartCenter]
                        // childの中心位置をSingletonなコレクションから取得
                        if let taskEndCenter = centers[child.id] {
                            let end = g[taskEndCenter]
                            
                            //Line(start: start, end: end).stroke()
                            RightAngleLine(start: start, end: end).stroke()
                        }
                    }
                })
            }
        })
    }
}

struct TaskTreeView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(alignment: .center, spacing: nil){
            TaskTreeView(task: .constant(tutorialRoutine.tasks[0]), node: {rt in Text(rt.wrappedValue.title).modifier(RoundedRectangleStyle(focused: false))})
        }
    }
}










