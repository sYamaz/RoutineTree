//
//  UIGCheckBox.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/12/03.
//

import SwiftUI

struct UIGCheckBox<Content:View>: View {
    let label:Content
    let checkedChanged:(Bool) -> Void
    @State private var checked:Bool = false
    
    
    var body: some View {
        Button(action: {
            withAnimation{
                self.checked.toggle()
            }
        }, label: {
            HStack{
                Image(systemName: checked ? "checkmark.circle" : "circle")
                label
            }.contentShape(Rectangle())
        }).onChange(of: checked, perform: {b in
            self.checkedChanged(checked)
        })
            .buttonStyle(.plain)
    }
}

extension UIGCheckBox{
    init(_ isOn:Binding<Bool>, label: () -> Content){
        self.label = label()
        self.checkedChanged = {b in
            isOn.wrappedValue = b
        }
    }
    
    init(label: () -> Content, checkedChanged:@escaping (Bool) -> Void){
        self.label = label()
        self.checkedChanged = checkedChanged
    }
    
}

struct UIGCheckBox_Previews: PreviewProvider {
    static var previews: some View {
        UIGCheckBox(label: {Text("text")}, checkedChanged: {b in
            
        })
    }
}
