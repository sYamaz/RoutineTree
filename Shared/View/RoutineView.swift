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
                routine: $routine,
                node: {
                    factory.generateNodeView(task: $0, editing: $editingTaskId)
                        .frame(minWidth:100, maxWidth:150, minHeight: 50, maxHeight: 100)
                        .padding(4)
                },
                root: {
                    StartTaskNodeView(routine: $0, editing: $editingTaskId)
                })
            
            // ボタンで隠れた部分をスクロールで移動できるようにするためのスペース
            Divider().padding(100)
            
        }
        .sheet(isPresented: $settingMode, onDismiss: nil, content: {
            RoutinePreferenceView(preference: routine.preference, editing: $settingMode, onCompleted: {p in routine.preference = p}, onCanceled: {})
        })
        .toolbar(content: {
            Button(action: {
                withAnimation{
                    self.settingMode = true
                }
            }, label: {Image(systemName: "ellipsis")})
        })
        .navigationTitle(Text(self.routine.preference.title))
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
