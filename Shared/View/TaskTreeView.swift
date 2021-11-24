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
        LazyVStack(alignment: .leading, spacing: nil, pinnedViews: .sectionHeaders){
            node(self.$task)
                .id($task.id)
                // Singletonなコレクション（PreferenceKey）にViewの中心座標を登録する
                .anchorPreference(key: CollectDict.self, value: .center, transform: {center in
                    [self.task.id: center]
                })
            LazyHStack(alignment: .top, spacing: nil, pinnedViews: .sectionHeaders){
                ForEach(task.children.indices, id: \.self){index in
                    let t = $task.children[index]
                    TaskTreeView(task:  t, node: self.node)
                }
            }
        }
        .backgroundPreferenceValue(CollectDict.self, {(centers:[TaskId:Anchor<CGPoint>]) in
            GeometryReader{g in
                ForEach(self.task.children, id: \.id, content:{child in
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

struct TaskTreeView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(alignment: .center, spacing: nil){
            TaskTreeView(task: .constant(previewTree), node: {rt in Text(rt.wrappedValue.title).modifier(RoundedRectangleStyle(focused: false))})
        }
    }
}

let previewRoutine:Routine = .init(id: .init(id: .init()), title: "Routine", tasks: [
    .init(id: .init(id: .init()), type: .Sync, title: "RoutineTask1", description: "Description", properties: .init(), children: [
        .init(id: .init(id: .init()), type: .Sync, title: "TooLongNameRoutineTask3", description: "Description", properties: .init(), children: .init())
    ]),
    .init(id: .init(id: .init()), type: .TimeSpan, title: "RoutineTask2", description: "Description", properties: [
        "minutes":"1",
        "seconds":"20"
    ], children: .init())
])
let previewTree = RoutineTask(id: .createStartTaskId(), type: .Start, title: "Start", description: "", properties: .init(), children: previewRoutine.tasks)

struct RoundedCircleStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(Circle().stroke())
            .background(Circle().fill(.background))
    }
}

struct RoundedRectangleStyle : ViewModifier{
    let focused:Bool
    func body(content: Content) -> some View {
        if(focused){
            content.padding(4)
                .background(RoundedRectangle(cornerRadius: 8).stroke(Color.accentColor))
                .background(RoundedRectangle(cornerRadius: 8).fill(.background).overlay(RoundedRectangle(cornerRadius: 8).fill(Color.accentColor.opacity(0.3))))
        } else {
        content
            .padding(4)
            .background(RoundedRectangle(cornerRadius: 8).stroke(Color.accentColor))
            .background(RoundedRectangle(cornerRadius: 8).fill(.background))
        }
    }
}

struct DashRoundedRectangleStyle: ViewModifier{
    func body(content: Content) -> some View {
        content
            .padding(4)
            .background(RoundedRectangle(cornerRadius: 8).stroke(style: StrokeStyle(lineWidth: 1, lineCap: .round, lineJoin: .round, miterLimit: 1, dash: [2], dashPhase: 1)))
            .background(RoundedRectangle(cornerRadius: 8).fill(.background))
    }
}


/// 中心位置を複数のTaskTreeViewで共有するためのSingletonなコレクション
struct CollectDict<Key: Hashable, Value>: PreferenceKey {
    static var defaultValue: [Key:Value] { [:] }
    static func reduce(value: inout [Key:Value], nextValue: () -> [Key:Value]) {
        value.merge(nextValue(), uniquingKeysWith: { $1 })
    }
}


/// TaskとTaskを繋ぐ線
struct Line: Shape {
    var start, end: CGPoint

    func path(in rect: CGRect) -> Path {
        Path { p in
            p.move(to: start)
            p.addLine(to: end)
        }
    }
}


extension Line {
    var animatableData: AnimatablePair<CGPoint.AnimatableData, CGPoint.AnimatableData> {
        get { AnimatablePair(start.animatableData, end.animatableData) }
        set { (start.animatableData, end.animatableData) = (newValue.first, newValue.second) }
    }
}
