//
//  NumberField.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/12/06.
//

import SwiftUI

struct NumberField: View {
    @Binding var v:Int
    let name:String
    let prompt:String
    
    
    var body: some View {
        TextField(name, value: $v, formatter: NumberFormatter(), prompt: Text(prompt))
            .multilineTextAlignment(.trailing)
            .keyboardType(.numberPad)
    }
}

struct NumberField_Previews: PreviewProvider {
    static var previews: some View {
        NumberField(v: .constant(0), name: "Name", prompt: "Name")
    }
}
