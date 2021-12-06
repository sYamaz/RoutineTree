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
            List{
                
                Section("Title"){
                    UIGTextField(text: $task.title, prompt: "Title").font(.title)
                        .multilineTextAlignment(.center)
                }
                
                Section("Description", content: {
                    TextEditor(text: $task.description).frame(height: 128)
                }).textCase(nil)
                
                
                Section("Timer"){
                    Toggle("Timer", isOn: .init(get: {task.type == .TimeSpan}, set: {task.type = $0 ? .TimeSpan : .Sync}))
                    if(task.type == .TimeSpan){
                        HStack(alignment: .center, spacing: nil, content: {
                            Text("Minute")
                            Spacer()
                            NumberField(v: $task.minutes, name: "minute", prompt: "minute")
                                .frame(width:70)
                                .textFieldStyle(.roundedBorder)
                        })
                        HStack(alignment: .center, spacing: nil, content: {
                            Text("Second")
                            Spacer()
                            NumberField(v: $task.seconds, name: "second", prompt: "second")
                                .frame(width:70)
                                .textFieldStyle(.roundedBorder)
                        })
                        
                    }
                }.textCase(nil)
            }
            
        }
        .background(.background)
    }
}

struct RoutineAddingView_Previews: PreviewProvider {
    static var previews: some View {
        RoutineAddingView(task: tutorialRoutine.tasks[0], onSubmit: {t in }, onCanceled: {}, shown: .constant(true))
    }
}
