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
        var plain_text: String?
        var userContentPage: String?
        
        init(plain_text: String?, userContentPage: String?) {
            self.plain_text = plain_text
            self.userContentPage = userContentPage
        }
        
        // Dynamic stateful properties about your activity go here!
    }
    
    // Fixed non-changing properties about your activity go here!

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
            
            
            VStack(alignment: .leading, spacing: 3) {
                
                VStack(alignment: .leading) {
                    Text("from: \(context.state.plain_text ?? "no title")")
                        .fontWeight(.regular)
                        .font(.system(size: 16))
                        .foregroundStyle(Color.gray)
                        .padding(.leading, 11)
                        .padding(.top, 12)
                    
                    
                    VStack(alignment: .leading) {
                        if let content = context.state.userContentPage {
                            Text("\n\(content)")
                                .fontWeight(.semibold)
                                .font(.system(size: 16))
                                .lineSpacing(3)
                                .lineLimit(7)
                                .padding(.leading, 11)
                        }
                    }
                    .padding(.trailing, 30)
                }
            }
            
            .padding(.bottom)
            .frame(alignment: .topLeading)
            .activityBackgroundTint(Color.black)
            .activitySystemActionForegroundColor(Color.black)
            
            
            
            
            
            
        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
                    
                    HStack {
                        Text("from:")
                            .fontWeight(.regular)
                            .font(.system(size: 16))
                            .foregroundStyle(Color.gray)
                            .padding(.top, 17.5)
                            .padding(.leading, 10)
                        Spacer()
                    }
                }
                
                DynamicIslandExpandedRegion(.center) {
                    
                    HStack {
                        Text(context.state.plain_text ?? "--")
                            .fontWeight(.regular)
                            .font(.system(size: 16))
                            .foregroundStyle(Color.gray)
                        Spacer()
                    }
                    
                    HStack(alignment: .top) {
                        
                        if let content = context.state.userContentPage {
                            Text("\(content)")
                                .fontWeight(.semibold)
                                .font(.system(size: 16))
                                .padding(.top, -5)
                       
                        }
                    }
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
                    .padding(.trailing, -4)
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
                
                HStack {
                    Text(context.state.plain_text ?? "--")
                        .fontWeight(.regular)
                        .foregroundStyle(Color.gray)
                        
                    Spacer()
                }
                
                
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
        DynamicRepAttributes()
        
    }
}

extension DynamicRepAttributes.ContentState {
    fileprivate static var titleName: DynamicRepAttributes.ContentState {
        DynamicRepAttributes.ContentState(plain_text: "", userContentPage: "")
        
    }
    
    fileprivate static var contentBody: DynamicRepAttributes.ContentState {
        DynamicRepAttributes.ContentState(plain_text: "", userContentPage: "")
    }
}

#Preview("Notification", as: .content, using: DynamicRepAttributes.preview) {
    DynamicRepLiveActivity()
} contentStates: {
    DynamicRepAttributes.ContentState.titleName
    DynamicRepAttributes.ContentState.contentBody
}
