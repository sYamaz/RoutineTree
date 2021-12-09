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
                RoutineEditView(task: $task, editingTaskId: $editing, onDelete: onDelete).textCase(nil)
            })
            .onDrag {
                
                // encodeToJson
                let provider = NSItemProvider()
                let enc = JSONEncoder()
                guard let data = try? enc.encode(task) else{
                    return provider
                }
                
                provider.registerDataRepresentation(
                    forTypeIdentifier: UTType.utf8PlainText.identifier,
                    visibility: .all){ completion -> Progress? in
                    completion(data, nil)
                    return nil
                }

                return provider
            } //preview: {Text("AAA").modifier(NodeStyle(color: .primary))}
            .onDrop(of: [.utf8PlainText], isTargeted: $isDropTargeted, perform: {providers in
                
                guard let provider = providers.first else {
                    return true
                }
                
                provider.loadItem(forTypeIdentifier: UTType.utf8PlainText.identifier, options: nil) { (data, error) in

                    let dec = JSONDecoder()
                    guard let ret = try? dec.decode(Routine.self, from: data as! Data) else{
                        return
                    }
            
                    if(ret.id == self.task.id){
                        // 自分自身にドロップできない
                        return
                    }else if(self.task.tasks.contains(where: {r in r.id == ret.id})){
                        // 元の位置にドロップする場合は何もしない
                        return
                    }
                    onDragDrop(ret, self.task.id)
                }

                
                return true
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
