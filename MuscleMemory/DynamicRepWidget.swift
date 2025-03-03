//
//  DynamicRepWidget.swift
//  MuscleMemory
//
//  Created by alex haidar on 2/27/25.
//

import SwiftUI
import WidgetKit
import ActivityKit
import Foundation



struct DynamicRepLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: DynamicRepAttributes.self) { context in
            
        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.center) {
                    Text("test1")
                }
                
                DynamicIslandExpandedRegion(.leading) {
                    Text("test2")
                }
                
            } compactLeading: {
                Text("test1")
            } compactTrailing: {
                Text("test2")
            } minimal: {
                Text("test3")
            }
        }
    }
}

