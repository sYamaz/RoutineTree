//
//  RoutineView.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/10.
//

import SwiftUI

/// TODO : TabコンテンツのViewを独立させる
struct TreeView: View {
    @State private var editingTaskId:RoutineId? = nil
    @State private var settingMode:Bool = false
    @State private var simpleMode:Bool = false
    @Binding var routine:Tree
    
    var body: some View {
        // tree view
        ScrollView([.horizontal, .vertical], showsIndicators: true){
            let colWidth:Double = 128
            let themeColor:Color = colorTable[routine.preference.colorId]
            
            TreeRootView(
                routine: $routine,
                node: {
                    RoutineNodeView(task: $0, editing: $editingTaskId)
                        .modifier(NodeStyle(color:themeColor))
                        .frame(width:colWidth)
                        .padding(8)
                },
                root: {
                    StartRoutineNodeView(routine: $0, editing: $editingTaskId)
                        .modifier(NodeStyle(color: themeColor))
                        .frame(width:colWidth)
                        .padding(8)
                })
            
            // ボタンで隠れた部分をスクロールで移動できるようにするためのスペース
            Divider().padding(100)
            
        }
        .sheet(isPresented: $settingMode, onDismiss: nil, content: {
            TreePreferenceView(preference: routine.preference, editing: $settingMode, onCompleted: {p in routine.preference = p}, onCanceled: {})
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

struct TreeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView(){
            TreeView(routine: .constant(tutorialRoutine))
        }
        .preferredColorScheme(.dark)
    }
}
