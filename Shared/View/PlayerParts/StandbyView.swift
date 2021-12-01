//
//  StandbyView.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/12/01.
//

import SwiftUI

struct StandbyView: View {
    
    @Binding var routines:[RoutineTree]
    @Binding var targetRoutine:PlayableRoutineTree
    @State private var routine:RoutineTree? = nil
    let onStarted:() -> Void
    var body: some View {
        HStack(alignment: .center, spacing: nil, content: {
            if(routines.isEmpty){
                Text("no routines exist")
                Spacer()
            }else{
            Picker("routine", selection: self.$routine, content: {
                ForEach(self.routines, id: \.id){r in
                    Text(r.title).tag(r)
                }
            })
            
                
            Spacer()
            if(routine == nil){
                Text("not selected")
            }
            else if(routine!.tasks.count == 0){
                Text("no tasks")
            } else {
                Button(action: {
                    // start routine
                    self.targetRoutine = routine!.makePlayable()
                    onStarted()
                }, label: {
                    Image(systemName: "play.fill").imageScale(.large)
                })
            }
            }
        }).padding()
            .onAppear(perform: {
                if(routines.isEmpty == false && routine == nil){
                    routine = routines[0]
                }
            })
    }
}

struct StandbyView_Previews: PreviewProvider {
    static var previews: some View {
        let routines = [tutorialRoutine]
        StandbyView(routines: .constant(routines), targetRoutine: .constant(routines[0].makePlayable()))
        {
        }
    }
}
