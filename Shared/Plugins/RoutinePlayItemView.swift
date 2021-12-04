//
//  RoutinePlayItemView.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/12/04.
//

import SwiftUI

struct RoutinePlayItemView: View {
    @Binding var task:PlayableRoutineTask
    var body: some View {
        VStack(alignment: .leading, spacing: nil){
            Text(self.task.title)
                .font(.body)
                .foregroundColor(.primary)
                .multilineTextAlignment(.leading)
            Text(self.task.description)
                .font(.caption)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.leading)
        }
    }
}

struct RoutinePlayItemView_Previews: PreviewProvider {
    static var previews: some View {
        RoutinePlayItemView(task: .constant(tutorialRoutine.tasks[0].makePlayable()))
    }
}
