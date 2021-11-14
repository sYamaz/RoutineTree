//
//  ContentViewModel.swift
//  RoutineTree (iOS)
//
//  Created by Shun Yamazaki on 2021/11/06.
//

import Foundation
import SwiftUI
class ContentViewModel: ContentViewModelDelegate{
    var router: ContentRouter

    init(router:ContentRouter){
        self.router = router
    }
}
