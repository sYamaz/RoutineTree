//
//  RoutineNodeView.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/12/04.
//

import SwiftUI

struct RoutineNodeView: View {
    @Binding var task:Routine
    @Binding var editing:RoutineId?
    @Binding var deletingMode:Bool
    var onDelete:(Routine) -> Void = {_ in }
    
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
                //editing = task.id
            }){
                VStack(alignment: .leading, spacing: nil){
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
                }.onTapGesture {
                    deletingMode = false
                    editing = task.id
                }
                .onLongPressGesture(perform: {
                    deletingMode = true
                })
            }
            .buttonStyle(.plain)
            .sheet(isPresented: showBinding, onDismiss: {
                
            }, content: {
                RoutineEditView(task: $task, editingTaskId: $editing).textCase(nil)
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
                        editing: .constant(nil), deletingMode: .constant(false))
        
    }
}
