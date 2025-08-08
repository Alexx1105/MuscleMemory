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
    
    let showEmoji: String?
    let showTitle: String?
    let showTabTitle: String?

    var body: some View {
        
            ZStack(alignment: .center) {
                Rectangle()
                    .fill(.white.opacity(elementOpacityDark))
                    .stroke(Color.white, lineWidth: 0.2)
                    .foregroundStyle(Color.mmDark)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.white, lineWidth: 0.2))
                    .opacity(0.8)
                    .cornerRadius(10)
                
                HStack(spacing: 20) {
                    
                    Menu {
                        Text("DynamicRep Settings \nfor \(showTabTitle ?? "")")
                            .fontWeight(.medium)
                            .foregroundStyle(Color.white)
                            .opacity(0.5)
                        
                        NavigationLink(destination: DynamicRepControlsView()) {
                            Label("Live activities", systemImage: "clock.badge")
                        }

                        
                        Button(role: .destructive, action: {
                        }) { Label("Disable", systemImage: "multiply.circle")
                            
                        }
                        
                    } label: {
                        
                        Image(systemName: "clock.arrow.2.circlepath")
                            .opacity(0.8)
                            .frame(width: 35, height: 35)
                            .padding(5)
                    }
                    
                    if showEmoji != nil || showTitle != nil {
                        Text(String("\(showEmoji ?? "")"))
                        Text(String("\(showTitle ?? "")"))
                            .fontWeight(.medium)
                        
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
    MainMenuTab(showEmoji: "", showTitle: "", showTabTitle: "")
}
