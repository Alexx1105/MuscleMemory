//
//  DynamicRepLiveActivity.swift
//  DynamicRep
//
//  Created by alex haidar on 3/26/25.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct DynamicRepAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!

    }

    // Fixed non-changing properties about your activity go here!
    var titleName: String?
    var contentBody: String?
    
    init(titleName: String?, contentBody: String?) {
        self.titleName = titleName
        self.contentBody = contentBody
    }
}

struct AppLogo: View {
    var body: some View {
     
        Image("appicon")
            .resizable()
            .scaledToFit()
            .clipShape(.circle)
    }
}


struct DynamicRepLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: DynamicRepAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Spacer()
                HStack {
            
                               Text("from \(context.attributes.titleName ?? "no title")")     //TO-DO: populate content here
                                   .fontWeight(.light)
                                   .font(.system(size: 16))
                                   .foregroundStyle(Color.gray)
                                   .padding(.top, 45)
                                   Spacer()
                           }
                            .frame(maxWidth: 500, maxHeight: 210)
                            .padding(.top)
                            .padding(.horizontal)
                
                
                           //Text("\(context.attributes.contentBody ?? "no content")")   //TO-DO: populate content here
                       }
                       Spacer()
                       .frame(height: 180)
                       .activityBackgroundTint(Color.black)
                       .activitySystemActionForegroundColor(Color.black)


        } dynamicIsland: { context in
            DynamicIsland {
               
                DynamicIslandExpandedRegion(.leading) {
                   
                    Text("from \(context.attributes.titleName ?? "no title")")
                        .fontWeight(.light)
                        .font(.system(size: 16))
                        .foregroundStyle(Color.gray)
                        .padding(.horizontal)
                }
                DynamicIslandExpandedRegion(.trailing) {
                   
                    VStack(alignment: .trailing) {
                        Circle()
                            .frame(width: 53, height: 50)
                            .foregroundStyle(Color.gray).opacity(0.20)
                            .overlay {
                                Image("mmicon")
                            }
                        Spacer()
                    }
                    
                }
                DynamicIslandExpandedRegion(.bottom) {
                    
                    HStack(spacing: 250) {
                       
                        Button(action: {}) {  //add functionality later
                            Image(systemName: "arrow.left")
                                .foregroundStyle(Color.white)
                                
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        Button(action: {}) {  //add functionality later
                            Image(systemName: "arrow.right")
                                .foregroundStyle(Color.white)
                                .buttonStyle(.plain)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    
                }
            } compactLeading: {
                ZStack {
                    AppLogo()
                }
            } compactTrailing: {
               
                Text("")
                
            } minimal: {
                Text("")
            }
            .widgetURL(URL(string: "MuscleMemory.KimchiLabs.com"))
            .keylineTint(Color.white)
        }
    }
}

extension DynamicRepAttributes {
    fileprivate static var preview: DynamicRepAttributes {
        DynamicRepAttributes(titleName: "", contentBody: "")
    
    }
}

extension DynamicRepAttributes.ContentState {
    fileprivate static var titleName: DynamicRepAttributes.ContentState {
        DynamicRepAttributes.ContentState()
      
     }
     
     fileprivate static var contentBody: DynamicRepAttributes.ContentState {
         DynamicRepAttributes.ContentState()
     }
}

#Preview("Notification", as: .content, using: DynamicRepAttributes.preview) {
   DynamicRepLiveActivity()
} contentStates: {
    DynamicRepAttributes.ContentState.titleName
    DynamicRepAttributes.ContentState.contentBody
}
