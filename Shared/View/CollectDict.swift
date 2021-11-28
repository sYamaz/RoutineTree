//
//  CollectDict.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/25.
//

import Foundation
import SwiftUI
/// 中心位置を複数のTaskTreeViewで共有するためのSingletonなコレクション
struct CollectDict<Key: Hashable, Value>: PreferenceKey {
    static var defaultValue: [Key:Value] { [:] }
    static func reduce(value: inout [Key:Value], nextValue: () -> [Key:Value]) {
        value.merge(nextValue(), uniquingKeysWith: { $1 })
    }
}
