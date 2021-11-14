//
//  ContentWireframe.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/06.
//

import Foundation
import SwiftUI
protocol ContentWireframe: ObservableObject, ContentNavigator {
    var viewToShow:AnyView {get}
}

protocol ContentNavigator{
    func navigateToRoutineView(routine:Routine) -> Void
    func navigateToRoutineListView() -> Void
}

class ContentNavigatorPreview: ContentNavigator{
    func navigateToRoutineView(routine: Routine) -> Void{
        
    }
    
    func navigateToRoutineListView() -> Void{
        
    }
}

class ContentWireframePreview: ContentWireframe{
    @Published var viewToShow: AnyView
    
    init(){
        self.viewToShow = AnyView(Text("Hello world"))
    }
    
    func navigateToRoutineView(routine: Routine) {
        self.viewToShow = AnyView(Text("Routine view"))
    }
    
    func navigateToRoutineListView() -> Void{
        self.viewToShow = AnyView(Text("Routine List view"))
    }
}
