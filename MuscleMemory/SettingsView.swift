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
            HStack() {
                    
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
    SettingsView()
}
