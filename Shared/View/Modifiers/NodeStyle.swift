//
//  TaskNodeStyle.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/12/06.
//

import Foundation
import SwiftUI
import UniformTypeIdentifiers
struct NodeStyle: ViewModifier{
    let color:Color
    var draggable:Bool = false
    func body(content: Content) -> some View {
        content
            .padding(4)
            .background(RoundedRectangle(cornerRadius: 8).fill(.regularMaterial))
            .background(RoundedRectangle(cornerRadius: 8).stroke(color, lineWidth: 2))
    }
}

struct DraggableStyle: ViewModifier{
    let routine:Routine
    func body(content: Content) -> some View {
        content.onDrag{
            // encodeToJson
            let provider = NSItemProvider()
            let enc = JSONEncoder()
            guard let data = try? enc.encode(routine) else{
                return provider
            }
            
            provider.registerDataRepresentation(
                forTypeIdentifier: UTType.utf8PlainText.identifier,
                visibility: .all){ completion -> Progress? in
                completion(data, nil)
                return nil
            }

            return provider
        }
    }
}

struct DroppableRoutineStyle:ViewModifier{
    @State var isDropTargeted:Bool = false
    let routine:Routine
    let onDragDrop:(Routine, RoutineId) -> Void
    
    func body(content: Content) -> some View {
        content.onDrop(of: [.utf8PlainText], isTargeted: $isDropTargeted, perform: {providers in
            
            guard let provider = providers.first else {
                return true
            }
            
            provider.loadItem(forTypeIdentifier: UTType.utf8PlainText.identifier, options: nil) { (data, error) in

                let dec = JSONDecoder()
                guard let ret = try? dec.decode(Routine.self, from: data as! Data) else{
                    return
                }
        
                if(ret.id == self.routine.id){
                    // 自分自身にドロップできない
                    return
                }else if(self.routine.tasks.contains(where: {r in r.id == ret.id})){
                    // 元の位置にドロップする場合は何もしない
                    return
                }
                onDragDrop(ret, self.routine.id)
            }
            return true
        })
    }
}

struct DroppableTreeStyle:ViewModifier{
    @State var isDropTargeted:Bool = false
    let tree:Tree
    let onDragDrop:(Routine, RoutineId) -> Void
    
    func body(content: Content) -> some View {
        content.onDrop(of: [.utf8PlainText], isTargeted: $isDropTargeted, perform: {providers in
            
            guard let provider = providers.first else {
                return true
            }
            
            provider.loadItem(forTypeIdentifier: UTType.utf8PlainText.identifier, options: nil) { (data, error) in

                let dec = JSONDecoder()
                guard let ret = try? dec.decode(Routine.self, from: data as! Data) else{
                    return
                }
        
                if(self.tree.tasks.contains(where: {r in r.id == ret.id})){
                    // 元の位置にドロップする場合は何もしない
                    return
                }
                onDragDrop(ret, .createStartTaskId())
            }

            
            return true
        })
    }
}
