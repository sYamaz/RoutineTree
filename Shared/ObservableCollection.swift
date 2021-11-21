//
//  ObservableCollection.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/20.
//

import Foundation
import Combine
class ObservableCollection<T>: ObservableObject{
    @Published private var collection:[T]
    private var subscription:Set<AnyCancellable> = .init()
    
    init(){
        collection = .init()
    }
    
    init(collection:[T]){
        self.collection = .init()
        self.addRange(array: collection)
    }
    
    func addRange(array:[T]) -> Void{
        
    }
    
    func add(array:T) -> Void{
        
    }
    
    func clear() -> Void{
        
    }
    
    func remove(where:(T) -> Bool) -> Void{
        
    }
    
    func remove(where:(T, Int) -> Bool) -> Void{
        
    }
}
