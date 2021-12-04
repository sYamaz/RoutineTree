//
//  RoutinePreferenceView.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/12/03.
//

import SwiftUI

struct RoutinePreferenceView: View {
    @State private var simpleMode:Bool = false
    @Binding var routine:RoutineTree
    var body: some View {
        VStack(alignment: .leading, spacing: nil){
            HStack{Spacer()}
            
            UIGTextField(text: $routine.title, prompt: "Title")
                .font(.title).padding()
                .multilineTextAlignment(.center)
                .background(RoundedRectangle(cornerRadius: 8).fill(.regularMaterial))
            
            List{
                
                
                Toggle(isOn: $simpleMode, label: {Text("Simple tree mode")})
                
                Text("Theme color")
                
            }
            Spacer()
        }
        .padding()
    }
}

struct RoutinePreferenceView_Previews: PreviewProvider {
    static var previews: some View {
        RoutinePreferenceView(routine: .constant(tutorialRoutine))
            .preferredColorScheme(.dark)
    }
}
