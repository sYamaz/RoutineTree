//
//  RoutineView.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/10.
//

import SwiftUI

/// TODO : TabコンテンツのViewを独立させる
struct RoutineView<VM:RoutineViewModelDelegate & ObservableObject>: View {
    @ObservedObject var vm:VM
    
    @State var addMode:Bool = false
    @State var treeMode:Bool = false
    @State var editTitleMode:Bool = false
    @State var routineMode:Bool = false
    
    private let factory:TaskViewFactory
    
    init(vm:VM, factory:TaskViewFactory){
        self.vm = vm
        self.factory = factory
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: nil){
            // tree view
            ScrollView([.horizontal, .vertical], showsIndicators: true){
                // rootを一つにするため、treeでのみ使用するRoutineTaskを作成する
                
                TaskTreeRootView(
                    routine: .init(
                        get: {vm.routine},
                        set: {r in vm.updateRoutine(r)}),
                    node: {t in
                        factory.generateTreeItemView(task: t)
                            .frame(maxWidth:150)
                            .padding(8)
                    },
                    root: {r in
                        NavigationLink(
                            destination: {
                                StartTaskEditView(appendable: r)
                            }, label: {
                                Text("Start")
                            }).modifier(DashRoundedRectangleStyle())
                    })
            }
            // startbutton
            VStack(alignment: .center, spacing: nil){
                if(self.routineMode == false){
                    Button(action:{
                        // start routine
                        print(vm.routine.tasks)
                        self.routineMode = true
                        self.vm.play()
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
                        TaskPlayingView(routine: self.vm.routine, factory: self.factory)
                        Button("Quit"){
                            self.routineMode = false
                            self.vm.quit()
                        }
                    }
                    .padding()
                }
            }
        }
        .navigationTitle(Text(vm.routine.title))
        .background(.regularMaterial)
    }
}

struct RoutineView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            RoutineView(vm:RoutineViewModel(routine: previewRoutine), factory:taskViewFactory)
        }
    }
}
