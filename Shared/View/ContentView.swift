//
//  ContentView.swift
//  Shared
//
//  Created by Shun Yamazaki on 2021/11/06.
//

import SwiftUI

enum PlayerMode{
    case small
    case middle
}

enum PlayingState{
    case none
    case playing
    case completed
}

struct ContentView: View  {
    @Binding var targetId:RoutineId
    @Binding var routines:[RoutineTree]
    let router:RoutineViewFactory

    init(routines:Binding<[RoutineTree]>,
         router:RoutineViewFactory,
         targetId:Binding<RoutineId>){
        self._routines = routines
        self.router = router
        self._targetId = targetId
        
        if(self.routines.isEmpty){
            self.routines.append(tutorialRoutine)
        }
    }
    
    var body: some View {
        ZStack(alignment: .center){
            // リスト表示部分
            NavigationView(content: {
                List{
                    ForEach(self.$routines, id: \.id){r in
                        NavigationLink(destination: {
                            router.getRoutineView(routine: r)
                        }, label: {
                            Text(r.wrappedValue.title)
                        })
                    }
                    .onDelete(perform: {idxs in
                        // 削除
                        routines.remove(at: idxs.first!)
                    })
                }
                .listStyle(.plain)
                .navigationTitle(Text("Routines"))
                .toolbar(content: {
                    Button(action: {
                        let newId = RoutineId(id: .init())
                        let newTitle = "New routine"
                        let newTasks:[RoutineTask] = .init()
                        let newRoutine = RoutineTree(id: newId, title: newTitle, tasks: newTasks)
                        self.routines.append(newRoutine)
                    }, label: {
                        Image(systemName: "plus")
                    })
                })
            }).background(.regularMaterial)
            // プレイヤー部分
            VStack(alignment: .center, spacing: nil, content: {
                Spacer()
                RoutinePlayer(
                    routines: self.$routines,
                    targetId: $targetId,
                    factory: taskViewFactory)
                    .background(.ultraThinMaterial)
                
                
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        let routines = [
        tutorialRoutine
        ]

        let router = RoutineViewFactory()
        
        ContentView(routines: .constant(routines), router: router, targetId: .constant(tutorialRoutine.id))
    }
}
