//
//  ContentRouter.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/06.
//

import Foundation
import SwiftUI

/// RoutineViewを生成します
class RoutineViewFactory: ContentWireframe{

    func getRoutineView(routine:Routine) -> AnyView
    {
        let view = RoutineView(vm: RoutineViewModel(routine: routine), factory: taskViewFactory)
        return .init(view)
    }
}
