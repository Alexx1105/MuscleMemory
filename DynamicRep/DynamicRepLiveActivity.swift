//
//  DynamicRepLiveActivity.swift
//  DynamicRep
//
//  Created by alex haidar on 3/5/25.
//

import ActivityKit
import WidgetKit
import SwiftUI



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

struct AppLogo: View {
    var body: some View {
     
        Image("dynamicrep")
            .resizable()
            .scaledToFit()
            .clipShape(.circle)
    }
}

struct DynamicRepLiveActivity: Widget {

    var body: some WidgetConfiguration {
        ActivityConfiguration(for: DynamicRepAttributes.self) { context in
            
            VStack {
                
                HStack(spacing: 257) {
                   
                    Text("from \(context.attributes.titleName ?? "no title")")
                        .fontWeight(.light)
                        .font(.system(size: 16))
                        .foregroundStyle(Color.gray)
                    Circle()
                        .frame(width: 53, height: 50)
                        .foregroundStyle(Color.gray).opacity(0.23)
                        .overlay {
                            Image("mmicon")
                                
                               
                        }
                }
                .frame(maxWidth: 500, maxHeight: 210)
                Spacer()
                
                
                Text("\(context.attributes.contentBody ?? "no content")")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)
            .frame(width: 500, height: 300)
            
            
        } dynamicIsland: { context in
            DynamicIsland {
           
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("from \(context.attributes.titleName ?? "no title")")
             
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Circle()
                        
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("\(context.attributes.contentBody ?? "no content")")   
                }
            } compactLeading: {
                 AppLogo()
                
            } compactTrailing: {
                Text("")    //empty for now
            } minimal: {
                Text("hello")    //empty for now
            }
            .widgetURL(URL(string: "MuscleMemory.KimchiLabs.com"))
            .keylineTint(Color.white)
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
  
