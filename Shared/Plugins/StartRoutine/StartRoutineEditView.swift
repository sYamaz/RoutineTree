//
//  StatrTaskEditView.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/20.
//

import SwiftUI

struct StartRoutineEditView: View {
    
    @Binding var appendable:RoutineTree
    @Binding var editing:TaskId?
    var body: some View {
        VStack(alignment: .leading, spacing: nil){
            List{
                // next routines
                Section(content: {
                    if(self.$appendable.tasks.isEmpty){
                        HStack{
                            Spacer()
                            Text("No routines")
                            Spacer()
                        }
                    } else {
                        ForEach(self.$appendable.tasks, id:\.id){t in
                            Button(t.title.wrappedValue){
                                withAnimation{
                                    self.editing = nil
                                    print("nil")
                                    self.editing = t.id
                                    print(t.id.id)
                                }
                            }.buttonStyle(.plain)
                        }.onDelete(perform: {index in
                            for i in index{
                                self.appendable.tasks.remove(at: i)
                            }
                        })
                    }
                }, header: {
                    // add button
                    HStack{
                        Text("Next routine")
                        Spacer()
                        AddNewTaskButton(onSubmit: {t in
                            self.appendable.tasks.append(t)
                        })
                    }
                })
            }
        }
        .padding()
    }
}

struct StartRoutineEditView_Previews: PreviewProvider {
    static var previews: some View {
        let r = RoutineTree(id: .init(id: .init()), preference: .init(title: "routine name"), tasks: .init())
        
        StartRoutineEditView(appendable: .constant(r), editing: .constant(nil))
    }
}
