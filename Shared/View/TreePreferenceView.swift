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
                .padding()

            VStack{
                HStack{
                    Toggle(isOn: $preference.pinned, label: {
                        Image(systemName: "pin")
                        Text("Pin")
                    })
                }
                .padding(8)
                .background(RoundedRectangle(cornerRadius: 8).fill(.regularMaterial))
            }
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
