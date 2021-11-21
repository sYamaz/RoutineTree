//
//  AddNewTaskButtonFactory.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/20.
//

import Foundation
import SwiftUI
struct AddNewTaskButtonFactory{
    func generate(appendable:TaskAppendable) -> some View{
        return AddNewTaskButton(appendable: appendable, content: {t in
            Button("sync"){
                t.append(.init(id: .init(id: .init()), type: .Sync, title: "New Task", description: "Description", properties: .init(), children: .init()))
            }
            Button("timespan"){
                let newTask:RoutineTask = .init(id: .init(id: .init()), type: .TimeSpan, title: "New Task", description: "Description", properties: .init(), children: .init())
                newTask.setMinutes(1)
                newTask.setSeconds(0)
                t.append(newTask)
            }
        })
    }

}
