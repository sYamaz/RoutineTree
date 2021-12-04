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
    @State var color:Color = .blue
    
    let colorTable:[Color] = [
        .blue,
        .gray,
        .yellow,
        .red,
        .brown,
        .cyan,
        .green,
        .indigo,
        .mint,
        .orange,
        .pink,
        .purple
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: nil){
            HStack{Spacer()}
            
            UIGTextField(text: $routine.title, prompt: "Title")
                .font(.title).padding()
                .multilineTextAlignment(.center)
                .background(RoundedRectangle(cornerRadius: 8).fill(.regularMaterial))
            
            VStack(alignment: .center, spacing: nil, content: {
                HStack(alignment: .center, spacing: nil, content: {
                    Button(""){
                        color = .blue
                    }
                    .frame(width:50, height:50)
                    .background(Circle().fill(.mint))
                    .padding(4)
                    .background(Circle().stroke(.primary))
                })
            })
            
            List{
                
                
                Toggle(isOn: $simpleMode, label: {Text("Simple tree mode")})
                
                
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
