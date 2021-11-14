//
//  ContentViewModelDelegate.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/06.
//

import Foundation
protocol ContentViewModelDelegate: ObservableObject {
    var router:ContentRouter{get}
}
