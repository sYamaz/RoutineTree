//
//  TaskExtension.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/12/02.
//

import Foundation
extension Routine{
    var formattedTime:String{
        get{
            let min = self.minutes
            let sec = self.seconds
            return "\(min)min \(sec)sec"
        }
    }
    
    var minutes:Int{
        get{
            if let str = self.properties["minutes"]{
                if let ret = Int(str) {
                    return ret
                }
            }
            return 0
        }
        set{
            self.properties["minutes"] = String(newValue)
        }
    }
    
    var seconds:Int{
        get{
            if let str = self.properties["seconds"]{
                if let ret = Int(str) {
                    return ret
                }
            }
            return 0
        }
        set{
            self.properties["seconds"] = String(newValue)
        }
    }
}

extension PlayableRoutine{
    var formattedTime:String{
        get{
            let min = self.minutes
            let sec = self.seconds
            
            return "\(min)min \(sec)sec"
        }
    }
    var minutes:Int{
        get{
            if let str = self.properties["minutes"]{
                if let ret = Int(str) {
                    return ret
                }
            }
            return 0
        }
        set{
            self.properties["minutes"] = String(newValue)
        }
    }
    
    var seconds:Int{
        get{
            if let str = self.properties["seconds"]{
                if let ret = Int(str) {
                    return ret
                }
            }
            return 0
        }
        set{
            self.properties["seconds"] = String(newValue)
        }
    }
}
