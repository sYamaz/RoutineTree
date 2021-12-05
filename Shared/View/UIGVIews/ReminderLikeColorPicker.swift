//
//  ReminderLikeColorPicker.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/12/04.
//

import SwiftUI

let colorTable:[Color] = [
    .red,
    .orange,
    .yellow,
    .green,
    .teal,
    .blue,
    .indigo,
    .pink,
    .purple,
    .brown,
    .gray,
    .mint
]

struct ReminderLikeColorPicker: View {
    typealias ColorId = Int
    
    @State private var color:Color = .blue
    @Binding var selection:ColorId
    
    init(selection:Binding<ColorId>){
        self._selection = selection
    }
    
    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(), count: 6), content: {
            ForEach(colorTable.indices){i in
                
                let c = colorTable[i]
                Button(action: {
                    self.selection = i
                }, label: {
                    HStack{Spacer()}
                        .frame(width: 40, height: 40)
                        .background(Circle().fill(c))
                        .padding(8)
                        .background(Circle().stroke(.secondary, lineWidth: i == selection ? 4 : 0))
                })
                    .buttonStyle(.plain)
            }
        })
    }
}

struct ReminderLikeColorPicker_Previews: PreviewProvider {
    static var previews: some View {
        ReminderLikeColorPicker(selection: .constant(0))
            .preferredColorScheme(.dark)
    }
}
