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
        return AddNewTaskButton(){t in
            appendable.wrappedValue.tasks.append(t)
        }
    }
    
    func generate(appendable:Binding<RoutineTree>) -> some View{
        return AddNewTaskButton() {t in
            appendable.wrappedValue.tasks.append(t)
        }
    }

}
