//
//  RoutinePreferenceView.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/12/03.
//

import SwiftUI

struct TreePreferenceView: View {
    @State var preference:TreePreference
    @Binding var editing:Bool
    let onCompleted:(TreePreference) -> Void
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
            
            HIGTextField(text: $preference.title, prompt: "Title")
                .font(.title).padding()
                .multilineTextAlignment(.center)
                .background(RoundedRectangle(cornerRadius: 8).fill(.regularMaterial))
                .foregroundColor(colorTable[preference.colorId])
                .padding()
            
            VStack(alignment: .center, spacing: nil, content: {
                HStack{Spacer()}
                RoutineNodeView(task: .constant(.init(id: .init(id: .init()), type: .Sync, title: "Preview", description: "color preview", properties: .init(), tasks: .init())), editing: .constant(nil), deletingMode: .constant(false), color: colorTable[preference.colorId])
                    .padding()
                
                ReminderLikeColorPicker(selection: $preference.colorId)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 8).fill(.regularMaterial))
                    .padding()
            }).background(RoundedRectangle(cornerRadius: 8).fill(.regularMaterial))
                .padding()
            
            

            Spacer()
        }
        .padding()
    }
}

struct TreePreferenceView_Previews: PreviewProvider {
    static var previews: some View {
        TreePreferenceView(preference: .init(title: ""), editing: .constant(true), onCompleted: {r in }, onCanceled: {})
            .preferredColorScheme(.dark)
    }
}
