//
//  RoundedRectangleStyle.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/25.
//

import Foundation
import SwiftUI
struct RoundedRectangleStyle : ViewModifier{
    let focused:Bool
    func body(content: Content) -> some View {
        if(focused){
            content.padding(4)
                .background(RoundedRectangle(cornerRadius: 8).stroke(Color.accentColor))
                .background(RoundedRectangle(cornerRadius: 8).fill(.background).overlay(RoundedRectangle(cornerRadius: 8).fill(Color.accentColor.opacity(0.3))))
        } else {
        content
            .padding(4)
            .background(RoundedRectangle(cornerRadius: 8).stroke(Color.accentColor))
            .background(RoundedRectangle(cornerRadius: 8).fill(.background))
        }
    }
}
