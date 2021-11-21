//
//  TaskWireframe.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/10.
//

import Foundation
import SwiftUI
protocol TaskTemplateGeneratorDelegate{
    func generateTreeItemView(task:RoutineTask) -> AnyView
}
