//
//  UIGTextField.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/30.
//

import SwiftUI


/// TextField according to iOS user interface guidelines
struct HIGTextField<Leading:View, Trailing:View>: View {
    
    @Binding public var text:String
    let prompt:String
    let leading:Leading
    let trailing:Trailing
    
    @State private var editing:Bool = false
    
    init(text:Binding<String>,
         prompt:String,
         @ViewBuilder leading: (Binding<String>) -> Leading,
         @ViewBuilder trailing: (Binding<String>) -> Trailing){
        self._text = text
        self.prompt = prompt
        self.leading = leading(text)
        self.trailing = trailing(text)
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: nil, content: {
            leading
            // for future iOS
            // TextField("title", text: $task.title, prompt:Text("Routine name"))
            //                            .focused($titleFocused)
            //
            TextField(prompt, text: $text, onEditingChanged: {editing in
                
                    self.editing = editing
                
            }, onCommit: {})
            if(editing){
                Button(action: {
                    text = ""
                }, label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.secondary)
                }).transition(.opacity)
            }
            
            trailing
        })
    }
}

extension HIGTextField{
    // 前後に何の機能もないパターン
    init(text:Binding<String>, prompt:String) where Leading == EmptyView, Trailing == EmptyView{
        self.init(text: text, prompt: prompt, leading: {b in EmptyView()}, trailing: {b in EmptyView()})
    }
    
    // 先頭にUIを追加するパターン
    init(text:Binding<String>, prompt:String, leading:(Binding<String>) -> Leading) where Trailing == EmptyView{
        self.init(text: text, prompt: prompt, leading: leading, trailing: {b in EmptyView()})
    }
    
    // 末尾にUIを追加するパターン
    init(text:Binding<String>, prompt:String, trailing:(Binding<String>) -> Trailing) where Leading == EmptyView{
        self.init(text: text, prompt: prompt, leading: {b in EmptyView()}, trailing: trailing)
    }
}

struct HIGTextField_Previews: PreviewProvider {
    static var previews: some View {
        List{
            HIGTextField(text: .constant("aaaaa"),
                         prompt: "prompt")
            
            HIGTextField(text: .constant("aaaaa"),
                         prompt: "prompt",
                         leading: {b in Image(systemName: "play")})
            
            HIGTextField(text: .constant("aaaaa"),
                         prompt: "prompt",
                         trailing: {b in
                Button(action: {b.wrappedValue = b.wrappedValue + "bbbbb"
                }, label: {Image(systemName: "plus")}).buttonStyle(.plain)})
        }
    }
}
