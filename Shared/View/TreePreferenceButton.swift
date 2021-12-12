//
//  TreePreferenceButton.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/12/11.
//

import SwiftUI

struct TreePreferenceButton: View {
    @Binding var preference:TreePreference
    @State private var show:Bool = false
    var body: some View {
        Button(action: {
            self.show = true
        }, label: {
            Text("Show information")
        }).sheet(isPresented: $show, onDismiss: nil, content: {
            TreePreferenceView(preference: preference, editing: $show, onCompleted: {p in self.preference = p}, onCanceled: {})
        })
    }
}

struct TreePreferenceButton_Previews: PreviewProvider {
    static var previews: some View {
        TreePreferenceButton(preference: .constant(.init(title: "Tree")))
    }
}
