//
//  RoutinePreferenceView.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/12/03.
//

import SwiftUI

struct RoutinePreferenceView: View {
    @State var preference:RoutineTreePreference
    @Binding var editing:Bool
    let onCompleted:(RoutineTreePreference) -> Void
    let onCanceled:() -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: nil){
            HStack{
                Button(role: .cancel, action: {
                    onCanceled()
                    editing = false
                }, label: {
                    Text("Cancel")
                })
                Spacer()
                Button(action: {
                    onCompleted(preference)
                    editing = false
                }, label: {
                    Text("Done")
                }).disabled(preference.title == "")
            }
            
            UIGTextField(text: $preference.title, prompt: "Title")
                .font(.title).padding()
                .multilineTextAlignment(.center)
                .background(RoundedRectangle(cornerRadius: 8).fill(.regularMaterial))
                .foregroundColor(colorTable[preference.colorId])
                .padding()
            
//            ReminderLikeColorPicker(selection: $routine.colorId)
//                .padding()
//                .background(RoundedRectangle(cornerRadius: 8).fill(.regularMaterial))

            Spacer()
        }
        .padding()
    }
}

struct RoutinePreferenceView_Previews: PreviewProvider {
    static var previews: some View {
        RoutinePreferenceView(preference: .init(title: ""), editing: .constant(true), onCompleted: {r in }, onCanceled: {})
            .preferredColorScheme(.dark)
    }
}
