//
//  AddNewTaskButton.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/20.
//

import SwiftUI


struct AddNewTaskButton: View {
    @State var mode = false
    let onSubmit:(RoutineTask) -> Void
    
    var body: some View {
        
        HStack(alignment: .center, spacing: nil){
            Spacer()
            Button(
                action: {
                    mode = true
                },
                label: {
                    HStack{
                        Image(systemName: "plus")
                        Text("Add")
                    }
                })
                .sheet(isPresented: $mode, onDismiss: nil, content: {
                    RoutineAddingView(
                        task: .init(id: .init(id: .init()), type: .Sync, title: "", description: "", properties: .init(), tasks: .init()),
                        onSubmit: onSubmit,
                        onCanceled: {},
                        shown: $mode)
                })
        }
        
    }
}

struct AddNewTaskButton_Previews: PreviewProvider {
    static var previews: some View {
        AddNewTaskButton(onSubmit: {t in })
    }
}
