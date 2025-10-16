//
//  tab.swift
//  MuscleMemory
//
//  Created by alex haidar on 4/13/25.
//

import SwiftUI
import Foundation



struct MainMenuTab: View {
    @Environment(\.colorScheme) var colorScheme
    private var elementOpacityDark: Double { colorScheme == .dark ? 0.1 : 0.5 }
    private var textOpacity: Double { colorScheme == .dark ? 0.8 : 0.8 }
    let showEmoji: String?
    let showTitle: String?

    
    var body: some View {
        
            ZStack(alignment: .center) {
                Rectangle()
                    .fill(.white.opacity(elementOpacityDark))
                    .stroke(Color.mmBackground, lineWidth: 0.2)
                    .foregroundStyle(Color.mmDark)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.mmDark, lineWidth: 0.2))
                    .opacity(0.8)
                    .cornerRadius(10)
                
                HStack(spacing: 20) {
                    
                    Menu {
                        Text("DynamicRep Settings")
                            .fontWeight(.medium)
                            .foregroundStyle(Color.white)
                            .opacity(0.5)
                        
                        NavigationLink(destination: DynamicRepControlsView()) {
                            Label("Live activities", systemImage: "clock.badge")
                        }
     
                        
                        Button(role: .destructive, action: {
                            Task {
                                do {
                                    let toInt = Query.accessQuery.queryID
                                    print(toInt)
                                    let convert = toInt.compactMap{Int($0)}
                                    print("converted id: \(convert)")
                                    let _ = try await supabaseDBClient.from("push_tokens").update(["offset_date" : "1970-01-01T00:00:00Z"]).in("id", values: convert).execute()
                                    
                                    print("Dynamic rep disabled from menu popover")
                                } catch {
                                    print("nil query id's or type mismatch error", error.localizedDescription)
                                }
                            }
                        
                            
                        }) { Label("Disable", systemImage: "multiply.circle")
                            
                        }
                        
                    } label: {
                        
                        Image(systemName: "clock.arrow.2.circlepath")
                            .foregroundStyle(Color.mmDark)
                            .opacity(0.8)
                            .frame(width: 35, height: 35)
                            .padding(5)
                    }
                    
                    if showEmoji != nil || showTitle != nil {
                        Text(String("\(showEmoji ?? "")"))
                        Text(String("\(showTitle ?? "")"))
                            .fontWeight(.medium)
                            .foregroundStyle(Color.mmDark)
                    } else {
                        Rectangle()
                            .cornerRadius(5)
                            .frame(width: 150, height: 20)
                            .opacity(0.1)
                        
                    }
                    
                    
                    Spacer()
                    Image("arrowChevron")
                        .opacity(0.8)
                        .padding(.trailing)
                    
                }
                .padding(.leading)
                
                
            }
            .frame(width: 370, height: 57)
        
        
    }
}

#Preview {
    MainMenuTab(showEmoji: "", showTitle: "")
}
