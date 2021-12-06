//
//  RoutinePlayer.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/23.
//

import SwiftUI
struct PlayerView: View {
    
    // 再生可能なルーティンリスト
    @Binding var routines:[Tree]
    @Binding var routineId:TreeId

    
    // 実行対象のルーティン
    @State private var targetRoutine:PlayableRoutineTree = .init(id: .init(id: .init()), title: "empty", tasks: [], colorId: 5)
    
    
    // プレイヤーの表示モード
    @State private var playerMode:PlayerMode = .small
    // プレイヤーの再生状態
    @State private var playing:Bool = false
    
    var body: some View {
        VStack(alignment: .center, spacing: nil, content: {
            if(playing == false){
                StandbyView(routines: $routines,
                            routineId: $routineId){selected in
                    self.targetRoutine = selected.makePlayable()
                    
                    self.targetRoutine = RoutineTreeInteractor().start(tree: targetRoutine)
                    withAnimation(){
                        self.playing = true
                    }
                }
            } else {
                VStack(alignment: .center, spacing: nil, content: {
                    ChevronUpDownBar(state: $playerMode).foregroundColor(colorTable[targetRoutine.colorId])
                    TreePlayingView(
                        routine: self.$targetRoutine,
                        onCompleted: {
                            RoutineTreeInteractor().forceFinished(tree: &targetRoutine)
                            withAnimation{
                                self.playing = false
                            }
                        })
                        .frame(height: self.playerMode == .small ? 200 : nil)
                        .padding()
                        .transition(.scale)
                })
            }
        }).transition(.scale)
    }
    
    struct PlayerView_Previews: PreviewProvider {
        static var previews: some View {
            PlayerView(
                routines: .constant([tutorialRoutine]),
                routineId: .constant(tutorialRoutine.id))
                .border(.gray)
        }
    }
}
