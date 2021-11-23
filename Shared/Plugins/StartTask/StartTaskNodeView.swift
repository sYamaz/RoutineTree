//
//  StartTaskNodeView.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/23.
//

import SwiftUI

struct StartTaskNodeView: View {
    @Binding var routine:Routine
    @State private var editing:Bool = false
    var body: some View {
        Button(action: {
            editing = true
        }, label: {
            Text(routine.title)
                .modifier(DashRoundedRectangleStyle())
        })
            .sheet(isPresented: $editing, onDismiss: {
                
            }, content: {StartTaskEditView(appendable: $routine)})
    }
}

struct StartTaskNodeView_Previews: PreviewProvider {
    static var previews: some View {
        StartTaskNodeView(routine: .constant(previewRoutine))
    }
}
