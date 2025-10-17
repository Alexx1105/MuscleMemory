//
//  IntervalSelectionLiveActivity.swift
//  MuscleMemory
//
//  Created by alex haidar on 10/16/25.
//

import ActivityKit
import WidgetKit
import KimchiKit
import SwiftUI


struct IntervalLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: IntervalLiveActivityAttributes.self) { context in
            
        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.center) {
                    VStack(alignment: .leading) {
                        
                        let intervalTitle = context.state.plainText ?? "--"
                        Text("for: \(intervalTitle)")
                            .fontWeight(.regular)
                            .font(.system(size: 16))
                            .foregroundStyle(Color.gray)
                       
                        Text("You’ll get flashcards every")
                            .fontWeight(.semibold)
                            .font(.system(size: 16))
                    }
                }
                DynamicIslandExpandedRegion(.trailing) {
                    
                    Circle()
                        .frame(width: 95, height: 65)
                        .foregroundStyle(Color.blue).opacity(0.5)
                    
                    var intervalNumberSelected: Double? = context.attributes.selectedInterval
                    Text("\(intervalNumberSelected ?? 0.0, format: .number)")
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.blue)
                    
                }
            } compactLeading: {
                 // Leave .leading empty for now
            } compactTrailing: {
                
                Circle()
                    .frame(width: 95, height: 65)
                    .foregroundStyle(Color.blue).opacity(0.5)
                
                var intervalNumberSelected: Double? = context.attributes.selectedInterval
                Text("\(intervalNumberSelected ?? 0.0, format: .number)")
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.blue)
                
            } minimal: {
                
            }.keylineTint(Color.blue)
        }
    }
}



extension IntervalLiveActivityAttributes {
    fileprivate static var preview: IntervalLiveActivityAttributes {
        IntervalLiveActivityAttributes(selectedInterval: 0.0)
        
    }
}

extension IntervalLiveActivityAttributes.ContentState {
    fileprivate static var titleInterval: IntervalLiveActivityAttributes.ContentState {
        IntervalLiveActivityAttributes.ContentState(plainText: "")
        
    }
}

#Preview("Notification", as: .content, using: IntervalLiveActivityAttributes.preview) {
    IntervalLiveActivity()
} contentStates: {
    IntervalLiveActivityAttributes.ContentState.titleInterval
}



