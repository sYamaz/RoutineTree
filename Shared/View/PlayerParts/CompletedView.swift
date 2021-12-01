//
//  CompletedView.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/12/01.
//

import SwiftUI

struct CompletedView: View {
    let onClick:() -> Void
    
    var body: some View {
        Button(action: {
            onClick()
        }, label: {
            HStack(alignment: .center, spacing: nil, content: {
                Spacer()
                Image(systemName: "hands.sparkles")
                Text("Completed!")
                Spacer()
            })
        })
            .padding()
    }
}

struct CompletedView_Previews: PreviewProvider {
    static var previews: some View {
        CompletedView(){
            
        }
            .border(.gray)
    }
}
