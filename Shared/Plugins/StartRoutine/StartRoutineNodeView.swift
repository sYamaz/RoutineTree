//
//  StartTaskNodeView.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/23.
//

import SwiftUI
import UniformTypeIdentifiers

struct StartRoutineNodeView: View {
    @Binding var routine:Tree
    @Binding var editing:RoutineId?
    var onDragDrop:(Routine, RoutineId) -> Void = {_,_ in }
    
    @State private var isDropTargeted = false
    
    var body: some View {
        Button(action: {editing = .createStartTaskId()}, label:{
            Text("start")
                .padding(8)})
            .buttonStyle(.plain)
            .sheet(isPresented: .init(
                get: {
                    if let id = editing {
                        return id.isStartTaskId()
                    }
                    return false
                },
                set: {b in
                    self.editing = b ? .createStartTaskId() : nil
                }
            ), onDismiss: {
                
            }, content: {
                StartRoutineEditView(appendable: $routine, editing: $editing)
            })
            .modifier(DroppableTreeStyle(tree: routine, onDragDrop: self.onDragDrop))
    }
}

struct StartRoutineNodeView_Previews: PreviewProvider {
    static var previews: some View {
        StartRoutineNodeView(routine: .constant(tutorialRoutine), editing: .constant(nil))
    }
}
