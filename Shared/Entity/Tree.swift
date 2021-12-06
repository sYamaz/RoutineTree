//
//  Routine.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/06.
//

import Foundation
import SwiftUI


struct Tree: Hashable, Identifiable, Codable{
    public let id: TreeId
    public var preference:TreePreference
    public var tasks:[Routine]
    
    public func makePlayable() -> PlayableRoutineTree{
        let cs = self.tasks.map{t in t.makePlayable()}
        let ret = PlayableRoutineTree(id: self.id, title: self.preference.title, tasks: cs, colorId: preference.colorId)
        return ret
    }
}

struct TreePreference: Hashable, Codable{
    var title:String
    var colorId:Int = 5
}
