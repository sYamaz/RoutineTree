//
//  PlayableRoutineTree.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/12/02.
//

import Foundation
struct PlayableRoutineTree:Equatable{
    var id:RoutineId
    var title:String
    var tasks:[PlayableRoutineTask]
}