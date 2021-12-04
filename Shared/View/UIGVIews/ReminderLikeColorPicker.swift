//
//  ReminderLikeColorPicker.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/12/04.
//

import SwiftUI

struct ReminderLikeColorPicker: View {

    let selectables:Dictionary<String,Color> = [
        "red":.red,
        "orange":.orange,
        "yellow":.yellow,
        "green":.green,
        "teal":.teal,
        "blue":.blue,
        "indigo":.indigo,
        "pink":.pink,
        "purple":.purple,
        "brown":.brown,
        "gray":.gray,
        "mint":.mint
    ]
    @State private var color:Color = .blue
    @Binding var selection:String
    
    init(selection:Binding<String>){
        self._selection = selection
    }
    
    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(), count: 6), content: {
            ForEach(Array(selectables.keys), id: \.self){key in
                
                let c = selectables[key]!
                Button(action: {
                    self.selection = key
                }, label: {
                    HStack{Spacer()}
                        .frame(width: 40, height: 40)
                        .background(Circle().fill(c))
                        .padding(8)
                        .background(Circle().stroke(.secondary, lineWidth: key == selection ? 4 : 0))
                })
                    .buttonStyle(.plain)
            }
        })
    }
}

struct ReminderLikeColorPicker_Previews: PreviewProvider {
    static var previews: some View {
        ReminderLikeColorPicker(selection: .constant("blue"))
            .preferredColorScheme(.dark)
    }
}
