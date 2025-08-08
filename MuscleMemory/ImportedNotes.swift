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
    
    public static let timed = DynamicRepScheduler()
    public init() {}
    
    @Environment(\.colorScheme) var colorScheme
    private var elementOpacityDark: Double { colorScheme == .dark ? 0.1 : 0.5 }
    private var textOpacity: Double { colorScheme == .dark ? 0.8 : 0.8 }
    
    public func callEndpoint() async {
        Task {
            do {
                ImportUserPage.shared.modelContextPagesStored(pagesContext: modelContextPage)
                try await ImportUserPage.shared.pageEndpoint()
            } catch {
                print("error fetching persisted page data")
            }
        }
    }

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
                
                   
                
                VStack {
                   
                    List(pageContent, id: \.userPageId) { block in
                        
                        Text(block.userContentPage ?? "")
                            .font(.system(size: 16)).lineSpacing(3)
                        
                            .listRowBackground(Color.mmBackground)
                            .listRowSeparator(.hidden)
                        
                    }
                    .listStyle(.plain)
                    Spacer()
                
                }
                .fontWeight(.medium)
                
                
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
            .background(Color.mmBackground)
        }
        .task { await callEndpoint()}
    }
        
}



#Preview {
    ImportedNotes()
}


