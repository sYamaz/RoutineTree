//
//  RoutineView.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/10.
//

import SwiftUI

/// TODO : TabコンテンツのViewを独立させる
struct RoutineView: View {
    @State var editingTaskId:TaskId? = nil
    @State private var settingMode:Bool = false
    @State private var simpleMode:Bool = false
    @Binding var routine:RoutineTree
    let factory:TaskViewFactory
    
    var body: some View {
        // tree view
        ScrollView([.horizontal, .vertical], showsIndicators: true){
            TaskTreeRootView(
                routine: .init(
                    get: {self.routine},
                    set: {r in self.$routine.wrappedValue = r}),
                node: {t in
                    factory.generateNodeView(task: t, editing: $editingTaskId)
                        .frame(minWidth:100, maxWidth:150, minHeight: 50, maxHeight: 100)
                },
                root: {r in
                    StartTaskNodeView(routine: $routine, editing: $editingTaskId)
                })
            
            // ボタンで隠れた部分をスクロールで移動できるようにするためのスペース
            Divider().padding(100).hidden()
            
        }
        .sheet(isPresented: $settingMode, onDismiss: nil, content: {
            RoutinePreferenceView(routine: $routine)
        })
        .toolbar(content: {
            Button(action: {
                withAnimation{
                    self.settingMode = true
                }
            }, label: {Image(systemName: "ellipsis")})
        })
        .navigationTitle(Text(self.routine.title))
    }
}

struct RoutineView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView(){
            RoutineView(routine: .constant(tutorialRoutine), factory: taskViewFactory)
        }
        .preferredColorScheme(.dark)
    }
}
