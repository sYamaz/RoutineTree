//
//  ContentView.swift
//  Shared
//
//  Created by Shun Yamazaki on 2021/11/06.
//

import SwiftUI

struct ContentView: View  {
    @ObservedObject private var vm:ContentViewModel
    @ObservedObject private var router:ContentRouter
    init(vm: ContentViewModel, router:ContentRouter){
        self.vm = vm
        self.router = router
    }
    var body: some View {
        VStack{
            router.viewToShow
        }.onAppear(perform: {
            vm.router.navigateToRoutineListView()
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        let routineDb = RoutineDatabase(routines: [
            .init(id: .init(id: .init()), title: "Routine1", taskIds: .init()),
            .init(id: .init(id: .init()), title: "Routine2", taskIds: .init())
        ])
        
        let taskDb = TaskDatabase(tasks: .init())
        let router = ContentRouter(routineDb: routineDb, taskDb: taskDb, generator: TaskTemplateGenerator(plugins: .init()))
        ContentView(vm: ContentViewModel(router: router), router:router)
    }
}
