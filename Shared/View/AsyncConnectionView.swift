//
//  AsyncConnectionView.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/08.
//

import SwiftUI

struct AsyncConnectionView: View {
    let width:Double
    let color:Color
    
    public init(){
        self.width = 8
        self.color = .primary
    }
    
    private init(width:Double, color:Color){
        self.width = width
        self.color = color
    }
    
    var body: some View {
        GeometryReader{g in
            Path{path in
                let hLeft:Double = 0
                let hRight:Double = (g.size.width + self.width) / 2
                let hTop:Double = (g.size.height - self.width) / 2
                let hBottom:Double = (g.size.height + self.width) / 2
                
                let vLeft:Double = (g.size.width - self.width) / 2
                let vRight:Double = (g.size.width + self.width) / 2
                let vTop:Double = (g.size.height - self.width) / 2
                let vBottom:Double = g.size.height
                
                // 開始
                path.move(to: .init(x: hLeft, y: hTop))
                // 右に線を引く
                path.addLine(to: .init(x: hRight, y: hTop))
                
                path.addLine(to: .init(x: vRight, y: vTop))
                
                // 下に線を引く
                path.addLine(to: .init(x: vRight, y: vBottom))
                
                // 折り返し
                path.addLine(to: .init(x: vLeft, y: vBottom))
                
                path.addLine(to: .init(x: vLeft, y: vTop))
                
                path.addLine(to: .init(x: hRight, y: hBottom))
                
                path.addLine(to: .init(x: hLeft, y: hBottom))
                
            }
            .fill(self.color)
        }
    }
}

extension AsyncConnectionView{
    public func lineColor(_ val:Double) -> Self{
        return .init(width: val, color: self.color)
    }
    
    public func lineWidth(_ val:Color) -> Self{
        return .init(width: self.width, color: val)
    }
}

struct AsyncConnectionView_Previews: PreviewProvider {
    static var previews: some View {
        AsyncConnectionView()
    }
}
