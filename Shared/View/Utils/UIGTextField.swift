//
//  UIGTextField.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/30.
//

import SwiftUI


/// TextField according to iOS user interface guidelines
struct UIGTextField: View {
    @Binding public var text:String
    @State private var editing:Bool = false
    
    var body: some View {
        HStack(alignment: .center, spacing: nil, content: {
            // for future iOS
            // TextField("title", text: $task.title, prompt:Text("Routine name"))
            //                            .focused($titleFocused)
            //
            TextField("title", text: $text, onEditingChanged: {editing in
                withAnimation{
                    self.editing = editing
                }
            }, onCommit: {})
            if(editing){
                Button(action: {
                    text = ""
                }, label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.secondary)
                }).transition(.opacity)
            }
        })
    }
}

struct UIGTextField_Previews: PreviewProvider {
    static var previews: some View {
        List{
            UIGTextField(text: .constant("eee"))
        }
    }
}
