//
//  ImmediateTaskNodeView.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/06.
//

import SwiftUI

struct SyncTaskNodeView: View {
    private let color:Color
    private let checked:Bool
    private let showTips:Bool
    @ObservedObject private var vm:SyncTaskNodeViewModel
    
    @State private var editMode:Bool = false
    @State private var editingTitle:String = ""
    @State private var editingDescription:String = ""
    
    public init(vm:SyncTaskNodeViewModel){
        self.vm = vm
        self.showTips = false
        self.color = .primary
        self.checked = false
    }
    
    private init(vm:SyncTaskNodeViewModel, color:Color, checked:Bool, showTips:Bool){
        self.vm = vm
        self.color = color
        self.checked = checked
        self.showTips = showTips
    }
    
    var body: some View {
        GeometryReader{g in
            let l:Double = min(g.size.width, g.size.height)
            let curveRadius:Double = l / 4
            let checkThickness = l / 8
            let checkOffsetX = l / 8
            let xOffset = g.size.width > g.size.height ? (g.size.width - g.size.height) / 2 : 0
            Path{path in
                path.addRoundedRect(in: .init(x: 0 + xOffset, y: 0, width: l, height: l), cornerSize: .init(width: curveRadius, height: curveRadius))
                
                if(self.checked){
                    path.addLines([
                        // 下線
                        .init(x: xOffset +  0 - checkOffsetX, y: l * 2 / 5),
                        .init(x: xOffset + l / 3, y: l * 9 / 10),
                        .init(x: xOffset + l + checkOffsetX, y: l * 1 / 5),
                        // 上線
                        .init(x: xOffset + l / 3, y: l * 9 / 10 - checkThickness),
                            
                    ])
                }
            }
            .fill(self.color)
            .onLongPressGesture{
                editMode = true
            }
            .sheet(isPresented: $editMode, onDismiss: {
                
            }, content: {
                VStack(alignment: .leading, spacing: nil){
                    HStack{
                        Spacer()
                        Button("Done(Save)"){
                            vm.updateTitle(self.editingTitle)
                            vm.updateDescription(self.editingDescription)
                            editMode = false
                        }
                    }
                    TextField("", text: $editingTitle, prompt: nil)
                        .font(.title)
                    TextEditor(text: $editingDescription)
                    Spacer()
                }
                .onAppear(perform: {
                    self.editingTitle = vm.task.title
                    self.editingDescription = vm.task.description
                })
                .padding()
            })
            
            if(showTips){
                Path{ path in
                    path.addRect(.init(x: xOffset + l + 8, y: l / 2, width: 100, height: 100))
                    
                }
                .fill(self.color)
            }
        }
    }
}

extension SyncTaskNodeView{
    public func check(_ isChecked:Bool) -> Self{
        return .init(vm:self.vm, color: self.color, checked: isChecked, showTips: self.showTips)
    }
    
    public func color(_ val:Color) -> Self{
        return .init(vm:self.vm, color:val, checked: self.checked, showTips: self.showTips)
    }
    
    public func showTips(_ val:Bool) -> Self{
        return .init(vm: self.vm, color: self.color, checked: self.checked, showTips: val)
    }
}

struct ImmediateTaskNodeView_Previews: PreviewProvider {
    static var previews: some View {
        
        let task = RoutineTask(owner:.init(id: .init()), id: .init(id: .init()), type: .Sync, title: "Title", description: "Description", previousTaskId: .createAddNewTaskId(), properties: .init())
        
        let vm = SyncTaskNodeViewModel(id: task.id, ps: .init(), db: TaskDatabase(tasks: [task]))
        
        SyncTaskNodeView(vm:vm)
            .color(.green)
            .check(false)
            .showTips(true)
            .frame(width: 128, height: 64)
    }
}
