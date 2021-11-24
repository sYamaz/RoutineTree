//
//  RoutineView.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/10.
//

import SwiftUI

/// TODO : TabコンテンツのViewを独立させる
struct RoutineView: View {
    @State var editingTaskId:TaskId? = nil
    @Binding var routine:Routine
    let factory:TaskViewFactory
    
    var body: some View {
        ScrollViewReader{svp in
            ZStack(alignment: .center){
                // tree view
                ScrollView([.horizontal, .vertical], showsIndicators: true){

                    TaskTreeRootView(
                        routine: .init(
                            get: {self.routine},
                            set: {r in self.$routine.wrappedValue = r}),
                        node: {t in
                            factory.generateNodeView(task: t, editing: $editingTaskId)
                                .frame(maxWidth:150)
                                .padding(8)
                        },
                        root: {r in
                            StartTaskNodeView(routine: $routine, editing: $editingTaskId)
                                .frame(maxWidth:150)
                                .padding(8)
                        })

                    // ボタンで隠れた部分をスクロールで移動できるようにするためのスペース
                    //Divider().padding(32).hidden()
                    Spacer(minLength: routine.routineMode ? 200 : 40)
                }
                
                // startbutton
                VStack(alignment: .center, spacing: nil){
                    Spacer()
                    RoutinePlayer(routine: $routine, factory: factory)
                        .padding()
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
