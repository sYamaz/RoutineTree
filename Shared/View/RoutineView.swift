//
//  RoutineView.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/10.
//

import SwiftUI

/// TODO : TabコンテンツのViewを独立させる
struct RoutineView: View {
    @State private var routineMode:Bool = false
    @State var editingTaskId:TaskId? = nil
    
    
    @Binding var routine:Routine
    let factory:TaskViewFactory
    
    var body: some View {
        GeometryReader{g in
        ZStack(alignment: .center){
            // tree view
            ScrollView([.horizontal, .vertical], showsIndicators: true){
                TaskTreeRootView(
                    routine: .init(
                        get: {self.routine},
                        set: {r in self.$routine.wrappedValue = r}),
                    node: {t in
                        factory.generateNodeView(task: t)
                            .frame(maxWidth:150)
                            .padding(8)
                    },
                    root: {r in
                        StartTaskNodeView(routine: $routine)
                    })
                
                Divider().padding(32).hidden()
            }
            // startbutton
            VStack(alignment: .center, spacing: nil){
                Spacer()
                if(self.routineMode == false){
                    Button(action:{
                        // start routine
                        print(self.routine.tasks)
                        self.routineMode = true
                        self.routine.start()
                        }){
                            HStack(alignment: .center, spacing: nil){
                                Image(systemName: "play")
                                Text("Start routine")
                            }
                            .padding()
                        }
                        .background(RoundedRectangle(cornerRadius: 32).stroke(Color.accentColor))
                        .background(RoundedRectangle(cornerRadius: 32).fill(.background))
                        
                } else {
                    VStack(alignment: .center, spacing: nil){
                        TaskPlayingView(
                            routine: .init(
                                get: {self.routine},
                                set: {r in self.routine = r}),
                            factory: self.factory)
                        Button("Quit"){
                            self.routineMode = false
                            self.routine.forceFinished()
                        }
                    }
                    .padding()
                }
            }
            //.background(Color.init(Color.RGBColorSpace.sRGB, white: 0, opacity: 0))
        }
    }
        .navigationTitle(Text(self.routine.title))
        //.background(.regularMaterial)
    }
}

struct RoutineView_Previews: PreviewProvider {
    static var previews: some View {

        NavigationView{
            RoutineView(routine: .constant(previewRoutine), factory: taskViewFactory)
        }
    }
}
