//
//  ContentView.swift
//  MuscleMemory
//
//  Created by alex haidar on 4/13/24.
//

import SwiftUI
import Foundation
import SwiftData



struct ImportedNotes: View {
    
    @Environment(\.modelContext) var modelContextPage
    
    @Query var pageContent: [UserPageContent]
    @Query var pageTitle: [UserPageTitle]
 
    
    @Environment(\.colorScheme) var colorScheme
    private var elementOpacityDark: Double { colorScheme == .dark ? 0.1 : 0.5 }
    private var textOpacity: Double { colorScheme == .dark ? 0.8 : 0.8 }
   
   

    var body: some View {
        
        NavigationView {
            
            VStack {
                HStack(spacing: 20) {
                    
                    NavigationLink(destination: MainMenu()) {
                        Image(systemName: "arrow.backward").foregroundStyle(Color.white.opacity(0.8))
                    }
                    
                    if let emojis = pageTitle.first?.emoji , let title = pageTitle.first?.plain_text {
                        Text("\(emojis)")
                        Text("\(title)")
                            .fontWeight(.semibold)
                        
                    } else {
                        Rectangle()
                            .cornerRadius(5)
                            .frame(width: 150, height: 20)
                            .opacity(0.1)
                        
                    }
                    Spacer()
                    Button(action: {}) {         //TO-DO: modify to prompt premium tier panel
                        Image("mmProIcon")
                            
                    }
                }
                .frame(maxWidth: 370)
                .padding(.top, 5)
                
                     
                Spacer()
                    Divider()
                     
                    .onAppear {
                        Task {
                            do {
                                ImportUserPage.shared.modelContextPagesStored(pagesContext: modelContextPage)
                                try await ImportUserPage.shared.pageEndpoint()
                            } catch {
                                print("error fetching persisted page data")
                            }
                        }
                    }
        
                VStack {
                    List(pageContent, id: \.userPageId) { block in
                       
                        let concatPage = (block.userContentPage ?? "").split(separator: "\n").map(String.init)
                        ForEach(concatPage, id: \.self) { textField in
                            Text(textField)
                                .lineSpacing(-7)
                                .listRowBackground(Color.mmBackground)
                                .listRowSeparator(.hidden)
                                
                        }
                       
                    }
                    .listStyle(.plain)
                    Spacer()
                }
                .fontWeight(.medium)
               
                
             
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
                    .padding(.horizontal)
                }
            }
            .background(Color.mmBackground)
          }
  
       }
     
    }
    



#Preview {
    ImportedNotes()
}


