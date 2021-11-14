//
//  TimeSpanTaskEditView.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/12.
//

import SwiftUI

struct TimeSpanTaskEditView: View {
    
    @Binding private var editingTitle:String
    @Binding private var editingDescription:String
    @Binding private var editingTimerSeconds:Int
    @Binding private var editingTimerMinutes:Int
    
    init(editingTitle:Binding<String>,
         editingDescription:Binding<String>,
         editingTimerSeconds:Binding<Int>,
         editingTimerMinutes:Binding<Int>){
        self._editingTitle = editingTitle
        self._editingDescription = editingDescription
        self._editingTimerSeconds = editingTimerSeconds
        self._editingTimerMinutes = editingTimerMinutes
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: nil){
            TextField("", text: $editingTitle, prompt: nil)
                .font(.title)
            TextEditor(text: $editingDescription)
                .frame(height:100)
            GeometryReader{g in
                HStack(alignment: .center, spacing: nil){
                    let minutes = 0..<60
                    let seconds = 0..<60
                    Spacer()
                    Picker(selection: $editingTimerMinutes, content: {
                        
                        ForEach(minutes.indices){idx in
                            let min = minutes[idx]
                            Text("\(min)")
                        }
                    }, label: {Text("min")})
                        .pickerStyle(.wheel)
                        .frame(width: 70)
                        .clipped()
                    
                    Text("min")
                    
                    Picker(selection: $editingTimerSeconds, content: {
                        
                        ForEach(seconds.indices){ idx in
                            let sec = seconds[idx]
                            Text("\(sec)")
                        }
                    }, label: {Text("sec")})
                        .pickerStyle(.wheel)
                        .frame(width:60)
                        .clipped()
                    
                    Text("sec")
                    
                    Spacer()
                }
            }
        }
        .padding()
    }
}

struct TimeSpanTaskEditView_Previews: PreviewProvider {
    static var previews: some View {
        TimeSpanTaskEditView(
            editingTitle: .constant("TimeSpan Title"),
            editingDescription: .constant("TimeSpan Description"),
            editingTimerSeconds: .constant(30),
            editingTimerMinutes: .constant(20))
    }
}
