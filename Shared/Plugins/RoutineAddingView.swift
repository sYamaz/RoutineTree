//
//  TaskPreferenceView.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/12/05.
//

import SwiftUI

struct RoutineAddingView: View {
    @State var task:RoutineTask
    let onSubmit:(RoutineTask) -> Void
    let onCanceled:() -> Void
    @Binding var shown:Bool
    
    var body: some View {
        VStack(alignment: .center, spacing: nil){
            HStack(alignment: .center, spacing: nil, content: {
                Button("Cancel"){
                    onCanceled()
                    shown = false
                }
                Spacer()
                Button("Done"){
                    onSubmit(task)
                    shown = false
                }.disabled(task.title == "")
            }).padding()
            VStack(alignment: .leading, spacing: nil, content: {
                Text("Title").font(.caption).foregroundColor(.secondary)
                UIGTextField(text: $task.title, prompt: "Title")
                Divider()
                
                Text("Description").font(.caption).foregroundColor(.secondary)
                TextEditor(text: $task.description).frame(height: 128)
                Divider()
                Toggle("Timer", isOn: .init(get: {task.type == .TimeSpan}, set: {task.type = $0 ? .TimeSpan : .Sync}))
                if(task.type == .TimeSpan){
                    MinSecPicker(min: $task.minutes, sec: $task.seconds)
                }
                Divider()
            }).padding()
            
            Spacer()
        }
        .padding()
        .background(.background)
    }
}

struct RoutineAddingView_Previews: PreviewProvider {
    static var previews: some View {
        RoutineAddingView(task: tutorialRoutine.tasks[0], onSubmit: {t in }, onCanceled: {}, shown: .constant(true))
    }
}
