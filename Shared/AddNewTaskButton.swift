//
//  AddNewTaskButton.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/20.
//

import SwiftUI


struct AddNewTaskButton<Content:View>: View {
    var appendable:TaskAppendable
    @State var mode = false
    
    private let content:Content
    
    init(appendable:TaskAppendable, @ViewBuilder content:(TaskAppendable) -> Content){
        self.appendable = appendable
        self.content = content(appendable)
    }
    
    var body: some View {

        HStack(alignment: .center, spacing: nil){
            Spacer()
            Button(
                action: {
                    mode = true
                },
                label: {
                    Text("add next task")
                })
                .confirmationDialog(Text("Select task type."), isPresented: $mode, titleVisibility: .visible, actions: {
                    self.content
                })
        }
        
    }
}

struct AddNewTaskButton_Previews: PreviewProvider {
    static var previews: some View {
        AddNewTaskButton(appendable: RoutineTask(id: .createStartTaskId(), type: .Start, title: "start", description: "description", properties: .init(), children: .init())){ t in
            Button("aaa"){
                
            }
        }
    }
}
