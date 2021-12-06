//
//  RoutineEditView.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/29.
//

import SwiftUI

struct RoutineEditView: View {
    @Binding var task:Routine
    @Binding var editingTaskId:RoutineId?
    
    var body: some View {
        VStack(alignment: .center, spacing: nil, content: {
            List{
                Section("Title"){
                    UIGTextField(text: $task.title, prompt: "Title")
                        .font(.title)
                        .multilineTextAlignment(.center)
                }
                
                // title and description
                Section("Description"){
                    // description
                    TextEditor(text: $task.description)
                        .frame(height:128)
                }
                
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
                
                // next routines
                Section(content: {
                    if(self.$task.tasks.isEmpty){
                        HStack{
                            Spacer()
                            Text("No routines")
                            Spacer()
                        }
                    } else {
                        ForEach(self.$task.tasks, id:\.id){t in
                            Button(t.title.wrappedValue){
                                withAnimation{
                                    self.editingTaskId = nil
                                    print("nil")
                                    self.editingTaskId = t.id
                                    print(t.id.id)
                                }
                            }.buttonStyle(.plain)
                        }.onDelete(perform: {index in
                            for i in index{
                                self.task.tasks.remove(at: i)
                            }
                        })
                    }
                }, header: {
                    // add button
                    HStack{
                        Text("Next routine")
                        Spacer()
                        AddNewRoutineButton(onSubmit: {t in
                            task.tasks.append(t)
                        })
                    }
                })
            }
        }).background(.background)
    }
}

struct RoutineEditView_Previews: PreviewProvider {
    static var previews: some View {
        RoutineEditView(
            task: .constant(tutorialRoutine.tasks[0]),
            editingTaskId: .constant(nil))
            .preferredColorScheme(.dark)
        
    }
}
