//
//  RoutineView.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/10.
//

import SwiftUI

struct RoutineView<VM:RoutineViewModelDelegate & ObservableObject>: View {
    @Environment(\.editMode) var mode
    @ObservedObject var vm:VM
    @State var addMode:Bool = false
    init(vm:VM){
        self.vm = vm
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: nil){
            HStack(alignment: .center, spacing: nil){
                
                EditButton()
                    .animation(.linear, value: 1)
                Spacer()
                Button(action: {
                    self.addMode = true
                }, label: {
                        Image(systemName: "plus")
                })
                    .confirmationDialog("confirm", isPresented: $addMode, actions: {
                        Button("aaa"){
                            
                        }
                        Button("bbb"){
                            
                        }
                    })
            }
            
            if(self.mode != nil && self.mode?.wrappedValue == .active){
                TextField("",
                          text: .init(
                            get: { vm.title },
                            set: {(txt, t) in
                                vm.updateTitle(txt)
                            }),
                          prompt: Text("input title here"))
                    .font(.largeTitle)
                    .border(TintShapeStyle(), width: 1)
            }
            else{
                HStack(alignment: .center, spacing: nil){
                    Text(vm.title).font(.largeTitle)
                    Spacer()
                }
            }
            List(){
                
                ForEach(vm.taskIds, id: \.id){id in
                    vm.getView(id)
                }
                .onDelete(perform: {idx in
                    for i in idx{
                        let taskId = vm.taskIds[i]
                        vm.deleteTask(taskId)
                    }
                })
            }
            .listStyle(.plain)
            
            Spacer()
            if(self.mode == nil || self.mode!.wrappedValue != .active){
                Button(action:{
                    
                }){
                    HStack(alignment: .center, spacing: nil){
                        Image(systemName: "play")
                        Text("Start routine")
                    }
                }
            }
        }
        .padding()
    }
}

struct RoutineView_Previews: PreviewProvider {
    static var previews: some View {
        let routineId:RoutineId = .init(id: .init())
        
        let taskId1:TaskId = .init(id: .init())
        let taskId2:TaskId = .init(id: .init())
        let taskId3:TaskId = .init(id: .init())
        
        let tasks:[RoutineTask] = [
            // first task
            .init(id: taskId1, type: .Sync, title: "Task1", description: "Sync task", followingTaskId: taskId2, properties: .init()),
            // second task
            .init(id: taskId2, type: .Sync, title: "Task2", description: "Sync task", followingTaskId: taskId3, properties: .init()),
            // third task
            .init(id: taskId3, type: .TimeSpan, title: "Task3", description: "Timer task", followingTaskId: .createAddNewTaskId(), properties: [
                "minutes":"3",
                "seconds":"0"
            ])
        ]
        let routines:[Routine] = [
            .init(id: routineId, title: "title", taskIds: tasks.map{t in t.id})
        ]
        

        
        let routineDb:RoutineDatabase = .init(routines: routines)
        let taskDb:TaskDatabase = .init(tasks: tasks)
        let plugins:[TaskTypeGeneratorDelegate] = [
            SyncTaskViewGenerator(ps: .init(), db: taskDb),
            TimeSpanTaskViewGenerator(db: taskDb)
        ]
        RoutineView(vm: RoutineViewModel(routineId: routineId, routineDb: routineDb, taskDb: taskDb, generator: TaskTemplateGenerator(plugins: plugins)))
    }
}
