//
//  RoutinePlayer.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/23.
//

import SwiftUI

struct RoutinePlayer: View {
    @Binding var routine:Routine
    @State private var routineMode:Bool = false
    
    let factory:TaskViewFactory
    var body: some View {
        VStack(alignment: .center, spacing: nil){
            Spacer()
            VStack(alignment: .center, spacing: nil){
                if(routineMode){
                    RoutinePlayingView(routine: self.$routine, factory: self.factory)
                        .frame(height:200)
                        .padding()
                    HStack{Spacer()}
                }
                Button(action:{
                    if(self.routine.routineMode){
                        // cancel routine
                        self.routine.forceFinished()
                        withAnimation(){
                            self.routineMode = false
                        }
                    }
                    else{
                        // start routine
                        self.routine.start()
                        withAnimation(){
                            self.routineMode = true
                        }
                    }
                }){
                    HStack(alignment: .center, spacing: nil){
                        let t:(String, String) = routineMode ?
                        (routine.allDone() ? ("Completed !", "hands.sparkles") : ("Cancel", "stop.fill")) : ("Start routine", "play")
                        
                        Image(systemName: t.1)
                        Text(t.0)
                    }
                    .padding()
                }
            }
            .background(RoundedRectangle(cornerRadius: 32).stroke(Color.accentColor))
            .background(RoundedRectangle(cornerRadius: 32).fill(.background))
        }
    }
}

struct RoutinePlayer_Previews: PreviewProvider {
    static var previews: some View {
        RoutinePlayer(routine: .constant(previewRoutine), factory: taskViewFactory)
    }
}
