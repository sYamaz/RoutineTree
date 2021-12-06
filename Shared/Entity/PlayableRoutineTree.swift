//
//  PlayableRoutineTree.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/12/02.
//

import Foundation
struct PlayableTree:Equatable{
    var id:TreeId
    var title:String
    var tasks:[PlayableRoutine]
    var colorId:Int
}
