//
//  ContentView.swift
//  Shared
//
//  Created by Shun Yamazaki on 2021/11/06.
//

import SwiftUI

enum PlayerMode{
    case hidden
    case small
    case middle
}

struct ContentView: View  {
    
    
    @ObservedObject private var vm:RoutineListViewModel
    @State private var playerMode:PlayerMode = .hidden
    @State private var playing:Bool = false
    @State private var playingRoutine:RoutineTree = tutorialRoutine
    private let router:RoutineViewFactory
    
    init(vm: RoutineListViewModel, router:RoutineViewFactory){
        self.vm = vm
        self.router = router
    }
    var body: some View {
        ZStack(alignment: .center){
            NavigationView(content: {
                List{
                    ForEach(vm.routines.indices, id: \.self){i in
                        let r = $vm.routines[i]
                        NavigationLink(destination: {
                            router.getRoutineView(routine: r)
                        }, label: {
                            Text(r.wrappedValue.title)
                        })
                    }
                    .onDelete(perform: {idxs in
                        // 削除
                        let target = vm.routines[idxs.first!]
                        vm.delete(target.id)
                    })
                }
                .navigationTitle(Text("Routines"))
                .toolbar(content: {
                    Button(action: {
                        let _ = vm.add()
                    }, label: {
                        Image(systemName: "plus")
                    })
                })
            }).background(.regularMaterial)
            
            VStack(alignment: .center, spacing: nil, content: {
                Spacer()
                RoutinePlayer(playerMode: $playerMode, routine: self.$playingRoutine, routines: $vm.routines, factory: taskViewFactory)
                    .background(.ultraThinMaterial)
                
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        let routineDb:RoutineDatabase = .init(routines: [
            tutorialRoutine
        ])
        let router = RoutineViewFactory()
        
        ContentView(vm: RoutineListViewModel(routineDb: routineDb), router: router)
    }
}
