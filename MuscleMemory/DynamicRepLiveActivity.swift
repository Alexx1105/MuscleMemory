//
//  DynamicRepLiveActivity.swift
//  DynamicRep
//
//  Created by alex haidar on 3/5/25.
//

import ActivityKit
import WidgetKit
import SwiftUI




struct compactAppIconView:  View {
    var body: some View {
        Image("AppIcon")
            .resizable()
            .frame(width: 44, height: 44)
    }
}


struct DynamicRepAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties go here
       
    }
    // Fixed non-changing properties go here
    var titleName: String?
    var contentBody: String?
       
        
    init(titleName: String?, contentBody: String?) {
        self.titleName = titleName
        self.contentBody = contentBody
    }
        
    
}
struct DynamicRepLiveActivity: Widget {
   
    @State private var dynamicTitle: String? = ""
    @State private var dynamicContent: String? = ""
    
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: DynamicRepAttributes.self) { context in
            // Lock screen/banner UI goes here
            Text("title: \(context.attributes.titleName ?? "no title")")       //TO-DO: change later
            Text("notes: \(context.attributes.contentBody ?? "no content")")

            VStack {
                Text("Hello")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("")//empty for now
                    compactAppIconView()
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Circle()
                        .frame(width: 91, height: 86)
                        
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("")    //empty for now
     
                }
            } compactLeading: {
                Text("")     //empty for now
            } compactTrailing: {
                Text("")    //empty for now
            } minimal: {
                Text("")    //empty for now
            }
            .widgetURL(URL(string: "MuscleMemory.KimchiLabs.com"))
            .keylineTint(Color.red)
        }
    }
}

extension DynamicRepAttributes {
    fileprivate static var preview: DynamicRepAttributes {
        DynamicRepAttributes(titleName: "", contentBody: "")    //empty for now
    }
}

extension DynamicRepAttributes.ContentState {
    fileprivate static var titleName: DynamicRepAttributes.ContentState {
        DynamicRepAttributes.ContentState()     //empty for now
     }
     
     fileprivate static var contentBody: DynamicRepAttributes.ContentState {
         DynamicRepAttributes.ContentState()      //empty for now
     }
}

#Preview("Notification", as: .content, using: DynamicRepAttributes.preview) {
    DynamicRepLiveActivity()
} contentStates: {
    DynamicRepAttributes.ContentState.titleName
    DynamicRepAttributes.ContentState.contentBody
}
  
