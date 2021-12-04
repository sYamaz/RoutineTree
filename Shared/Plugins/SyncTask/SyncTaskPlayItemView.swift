//
//  SyncTaskPlayItemView.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/15.
//

import SwiftUI

struct SyncTaskPlayItemView: View {
    @Binding var task:PlayableRoutineTask
    var body: some View {
        RoutinePlayItemView(task: $task)
    }
}

struct SyncTaskPlayItemView_Previews: PreviewProvider {
    static var previews: some View {
        let task = RoutineTask(id: .init(id: .init()), type: .Sync, title: "Title", description: "Description", properties: .init(), tasks:.init())
        
        SyncTaskPlayItemView(task: .constant(task.makePlayable()))
    }
}
