//
//  TaskTemplateGenerator.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/10.
//

import Foundation

enum TaskType: String, Codable{
    case Start = "start"
    case Sync = "sync"
    case TimeSpan = "TimeSpan"
    case Add = "add"
}
