//
//  DynamicRepBundle.swift
//  DynamicRep
//
//  Created by alex haidar on 3/3/25.
//

import WidgetKit
import SwiftUI

@main
struct DynamicRepBundle: WidgetBundle {
    var body: some Widget {
        DynamicRep()
        DynamicRepControl()
        DynamicRepLiveActivity()
    }
}
