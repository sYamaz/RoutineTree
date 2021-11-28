//
//  RoutinePlayer.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/23.
//

import SwiftUI

struct RoutinePlayer: View {
    @Binding var playerMode:PlayerMode
    @Binding var routine:RoutineTree
    @Binding var routines:[RoutineTree]
    let factory:TaskViewFactory
    
    
    
    var body: some View {
        VStack(alignment: .center, spacing: nil){
            VStack(alignment: .center, spacing: nil){
                if(routine.allDone()){
                    Button(action: {
                        withAnimation{
                            self.routine.forceFinished()
                            self.playerMode = .hidden
                        }
                    }, label: {
                        HStack(alignment: .center, spacing: nil, content: {
                            Spacer()
                            Image(systemName: "hands.sparkles")
                            Text("Completed!")
                            Spacer()
                        })
                    })
                        .padding()
                } else {
                    switch playerMode {
                    case .hidden:
                        HStack(alignment: .center, spacing: nil, content: {
                            Picker("routine", selection: self.$routine, content: {
                                ForEach(self.routines, id: \.id){r in
                                    Text(r.title).tag(r)
                                }
                            })
                            Spacer()
                            Button(action: {
                                // start routine
                                self.routine.start()
                                withAnimation(){
                                    self.playerMode = .small
                                }
                            }, label: {
                                Image(systemName: "play.fill").imageScale(.large)
                            })
                        }).padding()
                    case .small:
                        VStack(alignment: .center, spacing: nil, content: {
                            HStack(alignment: .center, spacing: nil, content: {
                                Button(action: {
                                    withAnimation{
                                        self.playerMode = .middle
                                    }
                                    print(playerMode)
                                }, label: {
                                    Image(systemName: "chevron.up")
                                    .padding()})
                            })
                            RoutinePlayingView(routine: self.$routine, factory: self.factory)
                                .frame(height:200)
                                .padding()
                        })
                            .transition(.scale)
                    case .middle:
                        VStack(alignment: .center, spacing: nil, content: {
                            HStack(alignment: .center, spacing: nil, content: {
                                Button(action: {
                                    withAnimation{
                                        self.playerMode = .small
                                    }
                                }, label: {
                                    Image(systemName: "chevron.down").padding()
                                })
                            })
                            RoutinePlayingView(routine: self.$routine, factory: self.factory)
                                .padding()
                        }).transition(.scale)
                    }
                }
            }
        }
    }
    
    struct RoutinePlayer_Previews: PreviewProvider {
        static var previews: some View {
            RoutinePlayer(playerMode: .constant(.hidden) , routine: .constant(tutorialRoutine), routines: .constant([tutorialRoutine]), factory: taskViewFactory)
                .border(.gray)
        }
    }
}
