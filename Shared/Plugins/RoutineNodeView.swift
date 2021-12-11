//
//  RoutineNodeView.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/12/04.
//

import SwiftUI
import UniformTypeIdentifiers

struct RoutineNodeView: View {
    @Binding var task:Routine
    @Binding var editing:RoutineId?
    @Binding var deletingMode:Bool
    
    @State private var isDropTargeted:Bool = false
    @State private var opacity:Double = 1.0
    let color:Color
    var onDelete:(Routine) -> Void = {_ in }
    var onDragDrop:(Routine, RoutineId) -> Void = {_,_ in }
    
    var body: some View {
        let showBinding = Binding<Bool>.init(
            get: {
                if(editing == nil){
                    return false
                }
                
                return editing!.id == task.id.id
            }, set: {
                editing = $0 ? task.id : nil
            })
        ZStack(alignment: .topLeading){
            Button(action:{
                // tapエフェクトのためだけの背景としてボタンを使用する
            }){
                VStack(alignment: .leading, spacing: nil, content:{
                    Text(self.task.title)
                        .font(.body)
                        .lineLimit(1)
                        .foregroundColor(.primary)
                    Text(self.task.description)
                        .font(.caption)
                        .lineLimit(1)
                        .foregroundColor(.secondary)
                    if(self.task.type == .TimeSpan){
                        HStack(alignment: .center, spacing: nil, content: {
                            Image(systemName: "clock")
                            Text(self.task.formattedTime)
                                .font(.caption)
                                .foregroundColor(.secondary)
                        })
                    }else{
                        Text("")
                    }
                    HStack{Spacer()} })
                    .modifier(NodeStyle(color: self.color))
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.3)){
                            self.opacity = 0.3
                        }
                        deletingMode = false
                        editing = task.id
                    }
                    .onLongPressGesture(minimumDuration: 1, maximumDistance: 10, perform: {deletingMode = true}, onPressingChanged: nil)
                    .modifier(DraggableStyle(routine: self.task, enabled: self.deletingMode))
                    .modifier(DroppableRoutineStyle(routine: self.task, onDragDrop: self.onDragDrop))
                
            }
            .buttonStyle(.plain)
            .background()
            .sheet(isPresented: showBinding, onDismiss: {
                
            }, content: {
                RoutineEditView(task: $task, editingTaskId: $editing, onDelete: onDelete).textCase(nil)
            })
            
            
            if(deletingMode){
                Button(action: {
                    print("delete")
                    onDelete(task)
                }, label: {
                    Image(systemName:"minus.circle.fill").foregroundColor(.gray)
                }).offset(x: -16, y: -16)
            }
        }
    }
}

struct RoutineNodeView_Previews: PreviewProvider {
    static var previews: some View {
        RoutineNodeView(task: .constant( tutorialRoutine.tasks[0]),
                        editing: .constant(nil), deletingMode: .constant(false), color:.blue)
        
    }
}
