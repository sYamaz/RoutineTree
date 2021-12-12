//
//  ContentView.swift
//  Shared
//
//  Created by Shun Yamazaki on 2021/11/06.
//

import SwiftUI

enum PlayerMode{
    case small
    case middle
}

enum PlayingState{
    case none
    case playing
}

struct ContentView: View  {
    @Binding var trees:[Tree]
    @Binding var treeId:TreeId
    
    // 現在実行中かどうか
    @State private var playing = false
    // プレイヤーの表示モード
    @State private var playerMode:PlayerMode = .small
    // 実行対象のルーティン
    @State private var targetPlayableTree:PlayableTree = .init(id: .init(id: .init()), title: "empty", tasks: [], colorId: 5)
    // シート用スイッチ
    @State private var adding:Bool = false
    
    var body: some View {
        // リスト表示部分
        let pinnedExists = trees.contains(where: {t in t.preference.pinned})
        ZStack(alignment: .center){
            NavigationView(content: {
                List{
                    // pin section
                    if(pinnedExists){
                        Section(content: {
                            ForEach(self.$trees, id:\.id){t in
                                if(t.preference.pinned.wrappedValue){
                                    NavigationLink(destination: {
                                        TreeView(routine: t, onStarted: self.onStarted(tree:))
                                            .navigationTitle(t.wrappedValue.preference.title)
                                    }, label: {
                                        HStack{
                                            Text(t.wrappedValue.preference.title)
                                        }
                                    }).contextMenu(menuItems: {
                                        self.contextMenu(tree: t)
                                    })
                                }
                            }
                            .onDelete(perform: {idxs in
                                // 削除
                                trees.remove(at: idxs.first!)
                            })
                        }, header: {
                            HStack{
                                Image(systemName: "pin")
                                Text("Pinned routines")
                            }
                        }, footer: {EmptyView()})
                    }
                    // normal section
                    Section(content:{
                        ForEach(self.$trees, id: \.id){t in
                            if(t.preference.pinned.wrappedValue == false){
                                NavigationLink(destination: {
                                    TreeView(routine: t, onStarted: self.onStarted(tree:))
                                        .navigationTitle(t.wrappedValue.preference.title)
                                }, label: {
                                    HStack{
                                        Text(t.wrappedValue.preference.title)
                                    }
                                })
                                    .contextMenu(menuItems: {
                                        self.contextMenu(tree: t)
                                    })
                            }
                        }
                        .onDelete(perform: {idxs in
                            // 削除
                            trees.remove(at: idxs.first!)
                        })
                    }, header:{
                        if(pinnedExists){
                            Text("Routines")
                        } else {
                            EmptyView()
                        }
                    })
                }
                .listStyle(.plain)
                .navigationTitle(Text("My Lists"))
                .toolbar(content: {
                    ToolbarItem(placement: .navigationBarTrailing, content: {
                        Button(action: {
                            self.adding = true
                        }, label: {
                            Image(systemName: "plus")
                        })
                            .sheet(isPresented: $adding, onDismiss: {
                                
                            }, content: {
                                TreePreferenceView(preference: .init(title: ""), editing: $adding,onCompleted: {rtp in
                                    let newRoutine = Tree(id: .init(id: .init()), preference: rtp, tasks: .init())
                                    self.trees.append(newRoutine)
                                    self.adding = false
                                },onCanceled: {self.adding = false})
                            })
                    })
                })
            }).background(.regularMaterial)
            // プレイヤー部分
            player
        }
    }
    
    @ViewBuilder
    var player: some View{
        VStack(alignment: .center, spacing: nil){
            Spacer()
            VStack(alignment: .center, spacing: nil, content: {
                if(playing == false){
                    let tree = trees.first(where: {t in t.id == self.treeId})
                    if(tree == nil){
                        
                    } else {
                        StandbyView(tree: tree!, onStarted: self.onStarted(tree:))
                    }
                }else{
                    VStack(alignment: .center, spacing: nil, content: {
                        ChevronUpDownBar(state: $playerMode)
                        TreePlayingView(
                            routine: self.$targetPlayableTree,
                            onCompleted: {
                                PlayableTreeInteractor().forceFinished(tree: &targetPlayableTree)
                                withAnimation{
                                    self.playing = false
                                }
                            })
                            .frame(height: self.playerMode == .small ? 200 : nil)
                            .padding()
                            .transition(.scale)
                    })
                }
            }).background(.ultraThinMaterial)
        }
    }
    
    /// NavigationLinkごとのコンテキストメニューを生成する
    /// - Parameter tree: NavigationLinkに割当たるTree参照
    /// - Returns: ContextMenuのView
    private func contextMenu(tree:Binding<Tree>) -> some View{
        return VStack{
            Toggle("Toggle pin", isOn: tree.preference.pinned)
            Button(role: .destructive, action: {
                self.trees.removeAll(where: {tt in tt.id == tree.wrappedValue.id})
            }, label: {
                Text("Delete this routine")})
        }
    }
    
    
    private func onStarted(tree:Tree) -> Void{
        self.treeId = tree.id
        self.targetPlayableTree = tree.makePlayable()
        self.targetPlayableTree = PlayableTreeInteractor().start(tree: self.targetPlayableTree)
        withAnimation(){
            self.playing = true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        let routines = [
            tutorialRoutine
        ]
        
        ContentView(trees: .constant(routines),
                    treeId: .constant(routines[0].id))
    }
}
