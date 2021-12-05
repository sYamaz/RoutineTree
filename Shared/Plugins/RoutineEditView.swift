//
//  RoutineEditView.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/29.
//

import SwiftUI

struct RoutineEditView<Content:View>: View {
    @Binding var task:RoutineTask
    @Binding var editingTaskId:TaskId?
    //// for future iOS
    //@FocusState private var titleFocused:Bool
    @State private var titleClearEnabled:Bool = false
    @State private var deleteConfirming:Bool = false
    let factory:AddNewTaskButtonFactory = .init()
    typealias SectionBuilder = (Binding<RoutineTask>) -> Content
    
    private let content:Content?
    init(task:Binding<RoutineTask>, editingTaskId:Binding<TaskId?>, @ViewBuilder specific: SectionBuilder){
        self._task = task
        self._editingTaskId = editingTaskId
        self.content = specific(task)
    }

    var body: some View {
        VStack(alignment: .center, spacing: nil, content: {
            List{
                // title and description
                Section("Title / Description"){
                    // title
                    UIGTextField(text: $task.title, prompt: "Title")
                    // description
                    TextEditor(text: $task.description)
                }
                
                // from builder
                content
                
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
                                    self.editingTaskId = t.id
                                }
                            }
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
                        factory.generate(appendable: $task)
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
            editingTaskId: .constant(nil)){_ in
            EmptyView()
        }
    }
}
