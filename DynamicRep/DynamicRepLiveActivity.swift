//
//  DynamicRepLiveActivity.swift
//  DynamicRep
//
//  Created by alex haidar on 3/3/25.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct DynamicRepAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct DynamicRepLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: DynamicRepAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension DynamicRepAttributes {
    fileprivate static var preview: DynamicRepAttributes {
        DynamicRepAttributes(name: "World")
    }
}

extension DynamicRepAttributes.ContentState {
    fileprivate static var smiley: DynamicRepAttributes.ContentState {
        DynamicRepAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: DynamicRepAttributes.ContentState {
         DynamicRepAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: DynamicRepAttributes.preview) {
   DynamicRepLiveActivity()
} contentStates: {
    DynamicRepAttributes.ContentState.smiley
    DynamicRepAttributes.ContentState.starEyes
}
