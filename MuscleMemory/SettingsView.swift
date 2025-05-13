//
//  SettingsView.swift
//  MuscleMemory
//
//  Created by alex haidar on 10/23/24.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.colorScheme) var colorScheme
    private var elementOpacityDark: Double { colorScheme == .dark ? 0.1 : 0.5 }
    private var textOpacity: Double { colorScheme == .dark ? 0.8 : 0.8 }
    
    var body: some View {
        
        VStack {
            HStack(spacing: 10) {
                     
                NavigationLink(destination: MainMenu()) {
                    Image(systemName: "arrow.backward").foregroundStyle(Color.white.opacity(0.8))
                }
                
                    Text("Settings")
                       .fontWeight(.semibold)
                       .opacity(textOpacity)
                Spacer()
                
                NavigationLink(destination: SignOutView()) {
                     Text("Log out")
                            .fontWeight(.regular)
                            .foregroundStyle(Color.gray)
                    }
                }
                 .frame(maxWidth: .infinity, alignment: .center)
                 .frame(maxHeight: 230)
                 .padding(.horizontal, 25)
           
          
            HStack {
                ZStack {
                    
                    Rectangle()
                        .frame(width: 370, height: 78)
                        .cornerRadius(18)
                        .foregroundStyle(.white)
                        .opacity(elementOpacityDark)
                        .overlay(RoundedRectangle(cornerRadius: 18)
                            .stroke(Color.white, lineWidth: 0.2)
                            .opacity(0.30)
                        )
                    
                        Image(systemName: "clock.badge.exclamationmark")
                        .padding(.trailing, 335)
                        .padding(.bottom,36)
                        
                        Text("Live flashcards")
                        .padding(.trailing, 170)
                        .padding(.bottom, 38)
                        .opacity(textOpacity)
                    
                    Image("arrowChevron")
                  .padding(.leading, 330)
                  .padding(.bottom, 38)
                  .opacity(textOpacity)
                        
                    ZStack {
                           
                            Spacer()
                            Rectangle()
                                .frame(width: 345, height: 0.5)
                                .foregroundStyle(Color.gray)
                                .padding(.leading, 24)
                            
                        }
                            Image(systemName: "circle.lefthalf.filled")
                               .padding(.trailing, 335)
                               .padding(.top, 36)
                               .opacity(textOpacity)
                            
                            Text("Appearence")
                           .padding(.trailing, 190)
                           .padding(.top, 38)
                           .opacity(textOpacity)
                    
                    NavigationLink(destination: LightDarkView()) {
                        Rectangle()
                            
                            .foregroundStyle(Color.clear)
                        .frame(width: 370, height: 37)
                        .padding(.top, 38)
                    }
                    
                   
                    
                          Image("arrowChevron")
                        .padding(.leading, 330)
                        .padding(.top, 38)
                        .opacity(textOpacity)
                    }
              }

                       
            Spacer()
            VStack {
                Divider()
                    .padding(.bottom, 10)
                
                HStack(spacing: 30) {
                    
                    NavigationLink(destination: MainMenu()) {
                        Image("menuButton")
                        
                    }
                    .frame(maxWidth: .infinity)
                    
                    
                    
                    NavigationLink(destination: SettingsView()) {
                        Image(systemName: "gear")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundStyle(Color.white.opacity(0.8))
                        
                    }
                    .frame(maxWidth: .infinity)
                    
                    NavigationLink(destination: NotionImportPageView()) {
                        Image(systemName: "plus.app")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundStyle(Color.white.opacity(0.8))
             
                        
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal)
                    
                }
                
            }.background(Material.ultraThin)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.mmBackground)
        .navigationBarBackButtonHidden()
    }
        
}



#Preview {
    SettingsView()
}
