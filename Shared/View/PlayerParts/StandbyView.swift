//
//  StandbyView.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/12/01.
//

import SwiftUI

struct StandbyView: View {
    
    @Binding var routines:[Tree]
    
    @Binding var routineId:TreeId
    let onStarted:(Tree) -> Void
    
    @State private var confirming:Bool = false
    
    
    var body: some View {
        HStack(alignment: .center, spacing: nil, content: {
            let r = routines.first(where: {r in r.id == routineId})
            let color:Color = r == nil ? .primary : colorTable[r!.preference.colorId]
            let name:String = r == nil ? "none" : r!.preference.title
            
            if(routines.isEmpty){
                Text("no routines exist")
                Spacer()
            }else{
                Button(action: {
                    confirming = true
                }, label: {
                    HStack(alignment: .center, spacing: nil, content: {
                        Text(name).frame(minWidth:70, maxWidth:128)
                        Image(systemName: "chevron.down")
                    })
                }).buttonStyle(.plain)
                    .confirmationDialog("Select routine.", isPresented: $confirming, actions: {
                        ForEach(routines, id: \.id){r in
                            Button(r.preference.title){
                                routineId = r.id
                            }.buttonStyle(.plain)
                        }
                    })
                    .padding(8)
                    .foregroundColor(color)
                    .background(RoundedRectangle(cornerRadius: 8).stroke(color))
                
                
                Spacer()
                
                
                if(r == nil){
                    Text("Routine does not exist")
                }
                else if(r!.tasks.count == 0){
                    Text("no tasks")
                } else {
                    Button(action: {
                        onStarted(r!)
                    }, label: {
                        Image(systemName: "play.fill").foregroundColor(color).imageScale(.large)
                    })
                }
            }
        }).padding()
    }
}

struct StandbyView_Previews: PreviewProvider {
    static var previews: some View {
        let routines = [tutorialRoutine]
        StandbyView(routines: .constant(routines), routineId: .constant(tutorialRoutine.id))
        {
            r in print(r.preference.title)
        }
    }
}
