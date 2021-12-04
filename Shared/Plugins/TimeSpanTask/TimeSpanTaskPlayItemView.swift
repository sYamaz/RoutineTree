//
//  TimeSpanTaskPlayItemView.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/15.
//

import SwiftUI
import Combine
struct TimeSpanTaskPlayItemView: View {
    
    @Binding var task:PlayableRoutineTask
    @State private var progress:Double = 0
    @State private var complete:Bool = false
    
    
    let timer = Timer.publish(every: 1, tolerance: nil, on: .main, in: .common, options: .none).autoconnect()
    init(task:Binding<PlayableRoutineTask>){
        self._task = task
        
    }
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: nil){
            RoutinePlayItemView(task: $task)
            HStack(alignment: .center, spacing: nil, content: {
                Image(systemName: "clock")
                Text(self.task.formattedTime)
                    .font(.caption)
                    .foregroundColor(.secondary)
                ProgressView(value: progress)
                    .progressViewStyle(.linear)
            })
        }
        .onReceive(timer, perform: {(now:Date) in
            guard let start = self.task.lastStartAt else {
                return
            }
            if(complete){
                return
            }
            let max = Double(self.task.minutes) * 60 + Double(self.task.seconds)
            let distance = start.distance(to: now)
            self.progress = distance / max
            if(self.progress >= 1){
                complete = true
            }
        })
    }
}

struct TimeSpanTaskPlayItemView_Previews: PreviewProvider {
    static var previews: some View {
        let taskId = TaskId(id: .init())
        
        let task = RoutineTask(id: taskId, type: .TimeSpan, title: "Title", description: "Description",  properties: [
            "minutes":"5",
            "seconds":"30"
        ],tasks: .init())
        
        
        TimeSpanTaskPlayItemView(task: .constant(task.makePlayable()))
    }
}
