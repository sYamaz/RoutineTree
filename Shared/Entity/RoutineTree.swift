//
//  Routine.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/06.
//

import Foundation
import SwiftUI


struct RoutineTree: Hashable, Identifiable, Codable{
    public let id: RoutineId
    public var preference:RoutineTreePreference
    public var tasks:[RoutineTask]
    
    public func makePlayable() -> PlayableRoutineTree{
        let cs = self.tasks.map{t in t.makePlayable()}
        let ret = PlayableRoutineTree(id: self.id, title: self.preference.title, tasks: cs, colorId: preference.colorId)
        return ret
    }
}

struct RoutineTreePreference: Hashable, Codable{
    var title:String
    var colorId:Int = 5
}
