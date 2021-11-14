//
//  SyncConnectionView.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/08.
//

import SwiftUI

struct SyncConnectionView: View {
    private let width:Double
    private let color:Color
    public init(){
        self.width = 8
        self.color = .primary
    }
    
    private init(lineWidth:Double, color:Color){
        self.width = lineWidth
        self.color = color
    }
    
    
    
    var body: some View {
        GeometryReader{g in
            
            let left:Double = (g.size.width - self.width) / 2
            let top:Double = 0
            let right:Double = (g.size.width + self.width) / 2
            let bottom:Double = g.size.height
            Path{ path in
                path.addLines([
                    .init(x: left, y: top),
                    .init(x: left, y: bottom),
                    .init(x: right, y: bottom),
                    .init(x: right, y: top)
                ])
            }.fill(self.color)
        }
    }
}

extension SyncConnectionView{
    public func lineWidth(_ val:Double) -> Self{
        return .init(lineWidth: val, color: self.color)
    }
    
    public func lineColor(_ val:Color) -> Self{
        return .init(lineWidth: self.width, color: val)
    }
}

struct SyncConnectionView_Previews: PreviewProvider {
    static var previews: some View {
        SyncConnectionView()
            .lineColor(.green)
            .frame(width: 128, height: 64)
    }
}
