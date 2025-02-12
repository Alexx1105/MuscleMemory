//
//  MainMenu.swift
//  MuscleMemory
//
//  Created by alex haidar on 10/21/24.
//

import SwiftUI
import Foundation



struct MainMenu: View {
    @State private var searchKeywords = String()    //modify text field to search keywords later
    @Environment(\.colorScheme) var colorScheme
    private var elementOpacityDark: Double { colorScheme == .dark ? 0.1 : 0.5 }
    private var textOpacity: Double { colorScheme == .dark ? 0.8 : 0.8 }
    
    @StateObject private var pageTitle = searchPages.shared
    
    
    var body: some View {
        
        VStack {
            TextField("Search keywords", text: $searchKeywords)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity)
                .padding(13)
                .background(RoundedRectangle(cornerRadius: 30).fill(.white.opacity(elementOpacityDark)))
                .overlay(RoundedRectangle(cornerRadius: 30)
                    .stroke(Color.white, lineWidth: 0.2)
                    .opacity(0.30))
                .padding()
            
            
                .padding(.bottom, 50)
            HStack {
                Text("Your notes from Notion:")
                    .fontWeight(.semibold)
                    .opacity(textOpacity)
                    .padding(.trailing, 160)
            }
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
