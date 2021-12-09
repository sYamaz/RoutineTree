//
//  TaskTemplateGenerator.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/10.
//

import Foundation

enum RoutineType: String, Codable{
    case Start = "start"
    case Sync = "sync"
    case TimeSpan = "TimeSpan"
    case Add = "add"
}

typealias DeleteAll = Bool
