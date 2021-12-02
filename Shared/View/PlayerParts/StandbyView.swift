//
//  StandbyView.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/12/01.
//

import SwiftUI

struct StandbyView: View {
    
    @Binding var routines:[RoutineTree]
    
    @Binding var routineId:RoutineId
    let onStarted:(RoutineTree) -> Void
    

    
    var body: some View {
        HStack(alignment: .center, spacing: nil, content: {
            if(routines.isEmpty){
                Text("no routines exist")
                Spacer()
            }else{
                Picker("routine", selection: self.$routineId, content: {
                    ForEach(self.routines, id: \.id){r in
                        Text(r.title).tag(r.id)
                    }
                })
                Spacer()
                
                let r = routines.first(where: {r in r.id == routineId})
                if(r == nil){
                    Text("Routine does not exist")
                }
                else if(r!.tasks.count == 0){
                    Text("no tasks")
                } else {
                    Button(action: {
                        onStarted(r!)
                    }, label: {
                        Image(systemName: "play.fill").imageScale(.large)
                    })
                }
            }
        }).padding()
            .onAppear(perform: {
                
            })
            .onChange(of: routines, perform: {rs in

            })
    }
}

struct StandbyView_Previews: PreviewProvider {
    static var previews: some View {
        let routines = [tutorialRoutine]
        StandbyView(routines: .constant(routines), routineId: .constant(tutorialRoutine.id))
        {
            r in print(r.title)
        }
    }
}
