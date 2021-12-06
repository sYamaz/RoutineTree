//
//  PlayableRoutineTask.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/12/02.
//

import Foundation
struct PlayableRoutine: Equatable{
    var id:RoutineId
    var type:RoutineType
    var title:String
    var description:String
    var properties:Dictionary<String,String>
    var children:[PlayableRoutine]
    var doing:PlayState
    var lastStartAt:Date?
}



