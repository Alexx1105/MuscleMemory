//
//  MainMenu.swift
//  MuscleMemory
//
//  Created by alex haidar on 10/21/24.
//

import SwiftUI
import Foundation



struct MainMenu: View {
   
    @Environment(\.colorScheme) var colorScheme
    private var elementOpacityDark: Double { colorScheme == .dark ? 0.1 : 0.5 }
    private var textOpacity: Double { colorScheme == .dark ? 0.8 : 0.8 }
    
    
    @StateObject var pageTitle = searchPages.shared
    @StateObject private var showUserEmail = OAuthTokens.shared
    
    var body: some View {
        
        VStack {
            

            HStack {
                Rectangle()
                    .cornerRadius(8)
                    .frame(width: 35, height: 35)
                    .foregroundStyle(Color.white).opacity(0.06)
                    .padding(.leading)
              
                VStack(spacing: 3) {
                Text("Workspace email")
                    .fontWeight(.regular)
                    .font(.system(size: 14))
                    .foregroundStyle(Color.white)
                    .frame(maxWidth: .infinity,maxHeight: 17, alignment: .leading)
                    
                
                 
              
                    if let displayEmail = showUserEmail.email {
                        Text("\(displayEmail)")
                            .fontWeight(.regular)
                            .font(.system(size: 14))
                            .foregroundStyle(Color.white).opacity(0.25)
                            .frame(maxWidth: .infinity,maxHeight: 17, alignment: .leading)
                    }
                   
                    
                }
                Spacer()
            }.frame(maxWidth: .infinity, maxHeight: 50)
            

                
                
            
            Spacer()
            HStack {
                Text("Your notes from Notion:")
                    .fontWeight(.semibold)
                    .opacity(textOpacity)
             
                
                Spacer()
                Button(action: {}) {         //TO-DO: modify to prompt premium tier panel
                    Image("mmProIcon")
                    
                }
            }

            .frame(maxWidth: 370, maxHeight: 100 )

            Spacer()
            
            
            VStack {
                ScrollView {
                    
                    Spacer()
                    NavigationLink {
                        ImportedNotes()
                        
                        
                            .navigationBarBackButtonHidden(true)
                    } label: {
                        
                        let emptyPage: String? = pageTitle.displaying?.plain_text     //broke up expressions to resolve compile-time error
                        let emptyEmojis: String? = pageTitle.emojis?.type
                        
                        if let emptyTab = emptyPage, emptyEmojis != nil {
                            
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
                                        Text("DynamicRep Settings \nfor \(emptyTab) ")
                                        
                                            .fontWeight(.medium)
                                            .foregroundStyle(Color.white)
                                            .opacity(0.5)
                                        
                                        Button("Live activities", systemImage: "clock.badge") {}
                                       
                                        Button(role: .destructive, action: {
                                        }) { Label("Disable", systemImage: "multiply.circle")
                                              
                                        }
                                            
                                    } label: {
                                        
                                        Image(systemName: "ellipsis")}
                                    .opacity(0.8)
                                    .frame(width: 35, height: 35)
                                    
                                    
                                    if let emojis = pageTitle.emojis?.emoji, let title = pageTitle.displaying?.plain_text {
                                        Text("\(emojis)")
                                        Text("\(title)")
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
                }
            }
            .foregroundStyle(Color.white.opacity(0.8))
          
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
    MainMenu()
}
