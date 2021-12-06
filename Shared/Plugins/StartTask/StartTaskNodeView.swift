//
//  StartTaskNodeView.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/23.
//

import SwiftUI

struct StartTaskNodeView: View {
    @Binding var routine:RoutineTree
    @Binding var editing:TaskId?
    var body: some View {
        Button(action: {editing = .createStartTaskId()}){
            Text("start")
                .padding(8)
        }.buttonStyle(.plain)
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
                StartTaskEditView(appendable: $routine, editing: $editing)
            })
    }
}

struct StartTaskNodeView_Previews: PreviewProvider {
    static var previews: some View {
        StartTaskNodeView(routine: .constant(tutorialRoutine), editing: .constant(nil))
    }
}
