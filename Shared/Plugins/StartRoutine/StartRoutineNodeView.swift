//
//  StartTaskNodeView.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/23.
//

import SwiftUI

struct StartRoutineNodeView: View {
    @Binding var routine:RoutineTree
    @Binding var editing:RoutineId?
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
                StartRoutineEditView(appendable: $routine, editing: $editing)
            })
    }
}

struct StartRoutineNodeView_Previews: PreviewProvider {
    static var previews: some View {
        StartRoutineNodeView(routine: .constant(tutorialRoutine), editing: .constant(nil))
    }
}
