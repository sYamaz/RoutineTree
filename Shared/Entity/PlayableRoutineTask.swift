//
//  PlayableRoutineTask.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/12/02.
//

import Foundation
struct PlayableRoutineTask: Equatable{
    var id:TaskId
    var type:TaskType
    var title:String
    var description:String
    var properties:Dictionary<String,String>
    var children:[PlayableRoutineTask]
    var doing:PlayState
    var lastStartAt:Date?
}



