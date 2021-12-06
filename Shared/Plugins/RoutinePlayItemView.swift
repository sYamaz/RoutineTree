//
//  RoutinePlayItemView.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/12/04.
//

import SwiftUI

struct RoutinePlayItemView: View {
    @Binding var task:PlayableRoutine
    
    // for type == .TimeSpan
    @State private var progress:Double = 0
    @State private var complete:Bool = false
    private let timer = Timer.publish(every: 1, tolerance: nil, on: .main, in: .common, options: .none).autoconnect()
    
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
            
            if(task.type == .TimeSpan){
                HStack(alignment: .center, spacing: nil, content: {
                    Image(systemName: "clock")
                    Text(self.task.formattedTime)
                        .font(.caption)
                        .foregroundColor(.secondary)
                    ProgressView(value: progress)
                        .progressViewStyle(.linear)
                })
            }
        }
        .onReceive(timer, perform: {(now:Date) in
            if(task.type != .TimeSpan){
                return
            }
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

struct RoutinePlayItemView_Previews: PreviewProvider {
    static var previews: some View {
        RoutinePlayItemView(task: .constant(tutorialRoutine.tasks[0].makePlayable()))
    }
}
