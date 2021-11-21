//
//  StatrTaskEditView.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/20.
//

import SwiftUI

struct StartTaskEditView: View {
    let factory:AddNewTaskButtonFactory = .init()
    var appendable:TaskAppendable
    var body: some View {
        VStack(alignment: .leading, spacing: nil){
            Spacer()
            factory.generate(appendable: appendable)
        }
        .padding()
    }
}

struct StartTaskEditView_Previews: PreviewProvider {
    static var previews: some View {
        let t = RoutineTask(id: .createStartTaskId(), type: .Start, title: "Start", description: "description", properties: .init(), children: .init())
        
        StartTaskEditView(appendable: t)
    }
}
