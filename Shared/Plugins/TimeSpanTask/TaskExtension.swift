//
//  TaskExtension.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/12/02.
//

import Foundation
extension RoutineTask{
    
    func getMinutes() -> Int{
        return Int( self.properties["minutes"]! )!
    }
    
    mutating func setMinutes(_ val:Int) -> Void{
        self.properties["minutes"] = String(val)
    }
    
    func getSeconds() -> Int{
        return Int(self.properties["seconds"]!)!
    }
    
    mutating func setSeconds(_ val:Int) -> Void{
        self.properties["seconds"] = String(val)
    }
}

extension PlayableRoutineTask{
    
    func getMinutes() -> Int{
        return Int( self.properties["minutes"]! )!
    }
    
    mutating func setMinutes(_ val:Int) -> Void{
        self.properties["minutes"] = String(val)
    }
    
    func getSeconds() -> Int{
        return Int(self.properties["seconds"]!)!
    }
    
    mutating func setSeconds(_ val:Int) -> Void{
        self.properties["seconds"] = String(val)
    }
}
