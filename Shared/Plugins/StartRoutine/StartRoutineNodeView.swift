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
            .onDrop(of: [.utf8PlainText], isTargeted: $isDropTargeted, perform: { providers in
                guard let provider = providers.first else {
                    return true
                }
                
                provider.loadItem(forTypeIdentifier: UTType.utf8PlainText.identifier, options: nil) { (data, error) in

                    let dec = JSONDecoder()
                    guard let ret = try? dec.decode(Routine.self, from: data as! Data) else{
                        return
                    }
            
                    if(self.routine.tasks.contains(where: {r in r.id == ret.id})){
                        // 元の位置にドロップする場合は何もしない
                        return
                    }
                    onDragDrop(ret, .createStartTaskId())
                }

                
                return true
            })
    }
}

struct StartRoutineNodeView_Previews: PreviewProvider {
    static var previews: some View {
        StartRoutineNodeView(routine: .constant(tutorialRoutine), editing: .constant(nil))
    }
}
