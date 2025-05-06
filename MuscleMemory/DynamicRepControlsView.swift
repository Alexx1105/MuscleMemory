//
//  DynamicRepControlsView.swift
//  MuscleMemory
//
//  Created by alex haidar on 5/4/25.
//

import SwiftUI
import SwiftData


struct DynamicRepControlsView: View {
    
    @Environment(\.colorScheme) var colorScheme
    private var elementOpacityDark: Double { colorScheme == .dark ? 0.1 : 0.5 }
    private var textOpacity: Double { colorScheme == .dark ? 0.8 : 0.8 }
    
    @Query var pageTitle: [UserPageTitle]
    
    @State var sliderSpeed: Double = 0.3
    
    var body: some View {
        VStack(spacing: 70) {
            
            
            HStack(alignment: .top, spacing: 100) {
                
                NavigationLink(destination: MainMenu()) {
                    Image(systemName: "arrow.backward").foregroundStyle(Color.white.opacity(0.8))
                }
                
                VStack(alignment: .trailing ,spacing: 5) {
                    Text("DynamicRep flashcard controls")
                        .fontWeight(.semibold)
                        .opacity(textOpacity)
                    
                    if let title = pageTitle.first?.plain_text {
                       
                        Text("\(title)")
                            .font(.system(size: 16)).lineSpacing(3)
                            .fontWeight(.medium)
                            .opacity(0.25)
                    }
                }
            }
            
           
            VStack(spacing: 5) {
                HStack(alignment: .top) {
                    Text("Frequency")
                        .fontWeight(.semibold)
                        .opacity(textOpacity)
                    
                    Spacer()
                }
                .padding(.leading, 15)
                
                HStack(alignment: .top) {
                    Text("Control how often you receive flashcard repetition\nnotifications containing your notes.")
                        .font(.system(size: 16)).lineSpacing(3)
                        .fontWeight(.medium)
                        .opacity(0.25)
                        .padding(.leading, 1)
                }
                
                HStack(alignment: .top) {
                    
                    Rectangle()
                        .frame(width: 370, height: 50)
                        .cornerRadius(50)
                        .opacity(0.06)
                        .padding(.top, 5)
                }
                HStack(alignment: .top, spacing: 60) {
                     Text("Off")
                        .fontWeight(.semibold)
                        .opacity(textOpacity)
                    
                    Text("1hr")
                        .fontWeight(.semibold)
                        .opacity(textOpacity)
                    
                    Text("2.3hrs")
                        .fontWeight(.semibold)
                        .opacity(textOpacity)
                    
                    Text("3.4hrs")
                        .fontWeight(.semibold)
                        .opacity(textOpacity)
                    
                    
                    
                }
                
                
                
            }
            
           
            Spacer()
            VStack(spacing: 5) {
                
                HStack(alignment: .top) {
                    Text("Auto disable after ")
                        .fontWeight(.semibold)
                        .opacity(textOpacity)
                    
                    Spacer()
                }
                .padding(.leading, 15)
                
                HStack(alignment: .top) {
                    Text(" MuscleMemory will reset after a full iteration over\n this notion page and repeat again unless one these\n settings are enabled.")
                        .font(.system(size: 16)).lineSpacing(3)
                        .fontWeight(.medium)
                        .opacity(0.25)
                        .padding(.leading, 1)
                }
                
                
                ZStack {
                    VStack {
                        Spacer()
                        Rectangle()
                            .frame(width: 370, height: 50)
                            .cornerRadius(50)
                            .opacity(0.06)
                        
                        HStack(alignment: .top, spacing: 100) {
                            Text("Off")
                                .fontWeight(.semibold)
                                .opacity(textOpacity)
                            
                            
                            Text("2.3hrs")
                                .fontWeight(.semibold)
                                .opacity(textOpacity)
                            
                            Text("3.4hrs")
                                .fontWeight(.semibold)
                                .opacity(textOpacity)
                            
                        }
                        
                    }
                 
                }
              
            }
            
            
            
            
        
            Spacer()
            VStack {
                Divider()
                    .padding()
                
                HStack {
                    
                    NavigationLink(destination: MainMenu()) {
                        Image("menuButton")
                        
                    }
                    .frame(maxWidth: .infinity)
                    
                    
                    
                    NavigationLink(destination: SettingsView()) {
                        Image("settingsButton")
                        
                    }
                    .frame(maxWidth: .infinity)
                    
                    NavigationLink(destination: NotionImportPageView()) {
                        Image("notionImportButton")
                        
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal)
                    
                }
                
            }
        
        }
        
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.mmBackground)
        .navigationBarBackButtonHidden()
    }
       
}

#Preview {
    DynamicRepControlsView()
}
