//
//  ChevronUpDownBar.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/12/01.
//

import SwiftUI

struct ChevronUpDownBar: View {
    @Binding var state:PlayerMode
    
    var body: some View {
        HStack(alignment: .center, spacing: nil, content: {
            Spacer()
            switch state {
            case .small:
                Button(action: {
                    withAnimation{
                        self.state = .middle
                    }
                }, label: {
                    Image(systemName: "chevron.up")
                    .padding()
                })
                
            case .middle:
                Button(action: {
                    withAnimation{
                        self.state = .small
                    }
                }, label: {
                    Image(systemName: "chevron.down").padding()
                })
            }
            Spacer()
        })
    }
}

struct ChevronUpDownBar_Previews: PreviewProvider {
    static var previews: some View {
        ChevronUpDownBar(state: .constant(.small))
            .border(.gray)
    }
}
