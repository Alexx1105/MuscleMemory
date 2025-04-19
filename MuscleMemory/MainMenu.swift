//
//  MainMenu.swift
//  MuscleMemory
//
//  Created by alex haidar on 10/21/24.
//

import SwiftUI
import Foundation
import SwiftData


@MainActor
struct MainMenu: View {
    
    @Environment(\.modelContext) var modelContext
    
    @Query var showUserEmail: [UserEmail]
    @Query var pageTitle: [UserPageTitle]
    
    @Environment(\.colorScheme) var colorScheme
    private var elementOpacityDark: Double { colorScheme == .dark ? 0.1 : 0.5 }
    private var textOpacity: Double { colorScheme == .dark ? 0.8 : 0.8 }
    
    //@StateObject var pageTitle = searchPages.shared

    
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
                    
                    .onAppear {
                           Task {
                                searchPages.shared.modelContextTitleStored(context: modelContext)
                                OAuthTokens.shared.modelContextEmailStored(emailStored: modelContext)
                           }
                       }
                  
                        if let email = showUserEmail.first?.personEmail {
                            Text("\(email)")
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
                    
                
                    let tappable = pageTitle.first?.plain_text != nil && pageTitle.first?.emoji != nil
                    
                    if tappable {
                        NavigationLink {
                            ImportedNotes()
                            
                                .navigationBarBackButtonHidden(true)
                        } label: {
                            
                            MainMenuTab(showEmoji: pageTitle.first?.emoji, showTitle: pageTitle.first?.plain_text, showTabTitle: pageTitle.first?.plain_text)
                                .opacity(pageTitle.first?.plain_text != nil && pageTitle.first?.emoji != nil ? 1 : 0)
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
