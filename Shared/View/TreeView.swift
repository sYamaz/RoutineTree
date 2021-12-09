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
    @State private var editMode:Bool = false
    @State private var deleteMode:Bool = false
    
    @Binding var routine:Tree
    
    var body: some View {
        let colWidth:Double = 128
        let themeColor:Color = colorTable[routine.preference.colorId]
        // tree view
        ScrollView([.horizontal, .vertical], showsIndicators: true){
            TreeRootView(
                routine: $routine,
                node: {task in
                    RoutineNodeView(task: task, editing: $editingTaskId, deletingMode: $deleteMode){target in
                        
                        self.routine = TreeInteractor().deleteRoutineFromTree(tree: routine, delete: target, all:false)
                        
                    } onDragDrop: {src, targetId in
//                        var ele = src
//                        ele.tasks.removeAll()
//
//                        let temp = TreeInteractor().deleteRoutineFromTree(tree: routine, delete: ele)
//
//                        self.routine.tasks = TreeInteractor().appendTo(tree: temp.tasks, element: ele, targetId: targetId)
//
                        dragdrop(src: src, targetId: targetId)
                    }
                        .modifier(NodeStyle(color:themeColor))
                        .frame(width:colWidth)
                        .padding(8)
                },
                root: {
                    StartRoutineNodeView(routine: $0, editing: $editingTaskId){src, targetId in
                        dragdrop(src: src, targetId: targetId)
                    }
                        .modifier(NodeStyle(color: themeColor))
                        .frame(width:colWidth)
                        .padding(8)
                        
                })
            
            // ボタンで隠れた部分をスクロールで移動できるようにするためのスペース
            Divider().padding(100)
            
        }
        .sheet(isPresented: $editMode, onDismiss: nil, content: {
            TreePreferenceView(preference: routine.preference, editing: $editMode, onCompleted: {p in routine.preference = p}, onCanceled: {})
        })
        .toolbar(content: {
            if(deleteMode){
                Button("Done"){
                    self.deleteMode = false
                }
            } else {
                Button(action: {
                    withAnimation{
                        self.editMode = true
                    }
                }, label: {Image(systemName: "ellipsis.circle")})
            }
        })
        .navigationTitle(Text(self.routine.preference.title))
    }
    
    private func dragdrop(src:Routine, targetId:RoutineId)
    {
        let interactor = TreeInteractor()
        var ele = src
        ele.tasks.removeAll()
        
        // 移動元から消す
        var temp = interactor.deleteRoutineFromTree(tree: routine, delete: ele)
        
        // 移動さきに追加する
        if(targetId.isStartTaskId()){
            temp.tasks.append(ele)
            self.routine.tasks = temp.tasks
        }else{
            self.routine.tasks = interactor.appendTo(tree: temp.tasks, element: ele, targetId: targetId)
        }
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
