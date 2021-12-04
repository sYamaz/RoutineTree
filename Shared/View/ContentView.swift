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
}

struct ContentView: View  {
    @Binding var routines:[RoutineTree]
    @Binding var routineId:RoutineId
    let router:RoutineViewFactory
    
    var body: some View {
        ZStack(alignment: .center){
            // リスト表示部分
            NavigationView(content: {
                List{
                    ForEach(self.$routines, id: \.id){r in
                        NavigationLink(destination: {
                            router.getRoutineView(routine: r)
                        }, label: {
                            HStack{
                                Image(systemName: "flowchart.fill")
                                    .foregroundColor(.yellow)
                                Text(r.wrappedValue.title)
                            }
                        })
                    }
                    .onDelete(perform: {idxs in
                        // 削除
                        routines.remove(at: idxs.first!)
                    })
                }
                .listStyle(.plain)
                .navigationTitle(Text("Routine trees"))
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
                    routineId: self.$routineId,
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
        
        ContentView(routines: .constant(routines),
                    routineId: .constant(routines[0].id),
                    router: router)
    }
}
