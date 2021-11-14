//
//  RoutineListView.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/06.
//

import SwiftUI

struct RoutineListView<VM>: View where VM : RoutineListViewModelDelegate {
    @ObservedObject private var vm:VM
    init(vm:VM){
        self.vm = vm
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: nil){
            HStack(alignment: .lastTextBaseline, spacing: nil){
                Spacer()
                Button("Add"){
                    let newRoutine = vm.add()
                    vm.moveTo(routine: newRoutine)
                }
            }.padding()
            List(){
                ForEach(vm.routines){r in
                    HStack(alignment: .firstTextBaseline, spacing: nil){
                        let title = r.title
                        
                        Button(action: {
                            vm.moveTo(routine: r)
                        }, label: {
                            Text(title)
                            Spacer()
                            Image(systemName: "")
                        })
                    }
                }.onDelete(perform: delete)
            }.listStyle(.automatic)
        }
    }
    
    func delete(at offsets: IndexSet) {
        if let idx = offsets.first{
            let deleteTarget = vm.routines[idx]
            vm.delete(deleteTarget.id)
        }
    }
}

struct RoutineListView_Previews: PreviewProvider {
    static var previews: some View {
        let db = RoutineDatabase(routines: [
            .init(id: .init(id: .init()), title: "Routine 1", taskIds: .init()),
            .init(id: .init(id: .init()), title: "Routine 2", taskIds: .init())
        ])
        let nav = ContentNavigatorPreview()
        let vm = RoutineListViewModel(routineDb: db, navigator: nav)
        RoutineListView(vm: vm)
    }
}
