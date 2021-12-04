//
//  RoutineNodeView.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/12/04.
//

import SwiftUI

struct RoutineNodeView<Content:View>: View {
    @Binding var task:RoutineTask
    let content:(Binding<RoutineTask>) -> Content
    
    var body: some View {
        VStack(alignment: .leading, spacing: nil){
            Text(self.task.title)
                .font(.body)
                .foregroundColor(.primary)
            Text(self.task.description)
                .font(.caption)
                .foregroundColor(.secondary)
            
            content($task)
        }
    }
}

struct RoutineNodeView_Previews: PreviewProvider {
    static var previews: some View {
        RoutineNodeView(task: .constant( tutorialRoutine.tasks[0])){_ in
            
            Text("additional")
        }
    }
}
