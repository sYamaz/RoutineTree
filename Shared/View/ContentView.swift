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
    @Binding var routines:[Tree]
    @Binding var routineId:TreeId
    
    @State var adding:Bool = false

    var body: some View {
        ZStack(alignment: .center){
            // リスト表示部分
            NavigationView(content: {
                List{
                    ForEach(self.$routines, id: \.id){r in
                        NavigationLink(destination: {
                            TreeView(routine: r)
                        }, label: {
                            HStack{
                                Text(r.wrappedValue.preference.title)
                            }
                        })
                    }
                    .onDelete(perform: {idxs in
                        // 削除
                        routines.remove(at: idxs.first!)
                    })
                }
                .listStyle(.plain)
                .navigationTitle(Text("My Lists"))
                .toolbar(content: {
                    ToolbarItem(placement: .navigationBarTrailing, content: {
                        Button(action: {
                            self.adding = true
                        }, label: {
                            Image(systemName: "plus")
                        })
                            .sheet(isPresented: $adding, onDismiss: {
                                
                            }, content: {
                                TreePreferenceView(preference: .init(title: ""), editing: $adding,onCompleted: {rtp in
                                    let newRoutine = Tree(id: .init(id: .init()), preference: rtp, tasks: .init())
                                    self.routines.append(newRoutine)
                                    self.adding = false
                                },onCanceled: {self.adding = false})
                            })
                    })
                })
            }).background(.regularMaterial)
            // プレイヤー部分
            VStack(alignment: .center, spacing: nil){
                Spacer()
            PlayerView(
                routines: self.$routines,
                routineId: self.$routineId)
                .background(.ultraThinMaterial)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        let routines = [
            tutorialRoutine
        ]

        ContentView(routines: .constant(routines),
                    routineId: .constant(routines[0].id))
    }
}
