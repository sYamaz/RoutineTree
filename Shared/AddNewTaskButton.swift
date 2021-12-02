//
//  AddNewTaskButton.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/20.
//

import SwiftUI


struct AddNewTaskButton<Content:View, T>: View {
    @Binding var appendable:T
    @State var mode = false
    @ViewBuilder var content:(Binding<T>) -> Content
    
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
                .confirmationDialog(Text("Select task type."), isPresented: $mode, titleVisibility: .visible, actions: {
                    self.content($appendable)
                })
        }
        
    }
}

struct AddNewTaskButton_Previews: PreviewProvider {
    static var previews: some View {
        AddNewTaskButton(appendable: .constant(RoutineTask(id: .createStartTaskId(), type: .Start, title: "start", description: "description", properties: .init(), tasks: .init()))){ t in
            Button("aaa"){
                
            }
        }
    }
}
