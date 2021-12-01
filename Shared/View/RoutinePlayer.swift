//
//  RoutinePlayer.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/23.
//

import SwiftUI
struct RoutinePlayer: View {

    // 再生可能なルーティンリスト
    @Binding var routines:[RoutineTree]
    // 再生対象のルーティンのID
    @Binding var targetId:RoutineId
    // タスクごとのUI生成器
    let factory:TaskViewFactory
    
    // 実行対象のルーティン
    @State private var targetRoutine:PlayableRoutineTree = .init(id: .init(id: .init()), title: "empty", tasks: [])
    // プレイヤーの表示モード
    @State private var playerMode:PlayerMode = .small
    // プレイヤーの再生状態
    @State private var playing:PlayingState = .none
    
    var body: some View {
        
        VStack(alignment: .center, spacing: nil, content: {
            switch playing {
            case .none:
                StandbyView(routines: $routines, targetRoutine: $targetRoutine){
                    self.targetRoutine = RoutineTreeInteractor().start(tree: targetRoutine)
                    withAnimation(){
                        self.playing = .playing
                    }
                }
            case .playing:
                VStack(alignment: .center, spacing: nil, content: {
                    ChevronUpDownBar(state: $playerMode)
                    RoutinePlayingView(
                        routine: self.$targetRoutine,
                        factory: self.factory){
                            RoutineTreeInteractor().forceFinished(tree: &targetRoutine)
                            withAnimation{
                                self.playing = .none
                            }
                        }
                        .frame(height: self.playerMode == .small ? 200 : nil)
                        .padding()
                }).transition(.scale)
            case .completed:
//                CompletedView(){
//                    withAnimation{
//                        RoutineTreeInteractor().forceFinished(tree: &targetRoutine)
//                        self.playing = .none
//                    }
//                }
                EmptyView()
            }
        }).onChange(of: targetRoutine, perform: {r in
//            if(self.playing == .playing){
//                if(RoutineTreeInteractor().allDone(tree:r)){
//                    withAnimation{
//                        self.playing = .completed
//                    }
//                }
//            }
        }).transition(.scale)
    }
    
    struct RoutinePlayer_Previews: PreviewProvider {
        static var previews: some View {
            RoutinePlayer(
                routines: .constant([tutorialRoutine]),
                targetId: .constant(tutorialRoutine.id),
                factory: taskViewFactory)
                .border(.gray)
        }
    }
}
