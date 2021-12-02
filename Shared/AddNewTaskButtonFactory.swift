//
//  AddNewTaskButtonFactory.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/20.
//

import Foundation
import SwiftUI
struct AddNewTaskButtonFactory{
    func generate(appendable:Binding<RoutineTask>) -> some View{
        
        return AddNewTaskButton(appendable: appendable, content: {t in
            Button("sync"){
                
                let newTask = RoutineTask(id: .init(id: .init()), type: .Sync, title: "New Task", description: "", properties: .init(), tasks: .init())
                t.wrappedValue.tasks.append(newTask)
                
            }
            Button("timespan"){
                var newTask:RoutineTask = .init(id: .init(id: .init()), type: .TimeSpan, title: "New Task", description: "Description", properties: .init(), tasks: .init())
                newTask.setMinutes(1)
                newTask.setSeconds(0)
                t.wrappedValue.tasks.append(newTask)
            }
        })
    }
    
    func generate(appendable:Binding<RoutineTree>) -> some View{
        return AddNewTaskButton(appendable: appendable, content: {t in
            Button("sync"){
                t.wrappedValue.tasks.append(.init(id: .init(id: .init()), type: .Sync, title: "New Task", description: "Description", properties: .init(), tasks: .init()))
            }
            Button("timespan"){
                var newTask:RoutineTask = .init(id: .init(id: .init()), type: .TimeSpan, title: "New Task", description: "Description", properties: .init(), tasks: .init())
                newTask.setMinutes(1)
                newTask.setSeconds(0)
                t.wrappedValue.tasks.append(newTask)
            }
        })
    }

}
