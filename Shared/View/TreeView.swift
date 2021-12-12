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
    private let treeInteractor:TreeInteractor = .init()
    @Binding var routine:Tree
    var onStarted:(Tree) -> Void = {_ in }
    
    var body: some View {
        let colWidth:Double = 128
        //let themeColor:Color = colorTable[routine.preference.colorId]
        // tree view
        ScrollView([.horizontal, .vertical], showsIndicators: true){
            
            TreeRootView(
                routine: $routine,
                node: {task in
                    RoutineNodeView(
                        task: task,
                        editing: $editingTaskId,
                        deletingMode: $deleteMode,
                        color: Color.accentColor,
                        onDelete: {target in self.routine = treeInteractor.deleteRoutineFromTree(tree: routine, delete: target, all:false)},
                        onDragDrop: {src, targetId in dragdrop(src: src, targetId: targetId)})
                        .frame(width:colWidth, height:colWidth/2)
                        .padding(8)
                },
                root: {
                    StartRoutineNodeView(
                        routine: $0,
                        editing: $editingTaskId,
                        onDragDrop:{src, targetId in dragdrop(src: src, targetId: targetId)})
                        .modifier(RootNodeStyle())
                        .frame(width:colWidth)
                        .padding(8)
                    
                },
                onStarted: self.onStarted)
            // ボタンで隠れた部分をスクロールで移動できるようにするためのスペース
            Divider().padding(100)
        }.onTapGesture {
            self.deleteMode = false
        }
        .navigationTitle(routine.preference.title)
        .sheet(isPresented: $editMode, onDismiss: nil, content: {
            TreePreferenceView(preference: routine.preference, editing: $editMode, onCompleted: {p in routine.preference = p}, onCanceled: {})
        })
        .toolbar(content: {
            Button(action: {
                if(deleteMode){
                    self.deleteMode = false
                } else {
                    self.editMode = true
                }
            }, label: {
                if(deleteMode){
                    Text("Done")
                } else {
                    Image(systemName: "ellipsis.circle")}
                
            })
        })
    }
    
    private func dragdrop(src:Routine, targetId:RoutineId)
    {
        let interactor = self.treeInteractor
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
