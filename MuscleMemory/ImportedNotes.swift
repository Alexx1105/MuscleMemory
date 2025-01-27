//
//  ContentView.swift
//  MuscleMemory
//
//  Created by alex haidar on 4/13/24.
//

import SwiftUI
import Foundation




struct ImportedNotes: View {
    
    @Environment(\.colorScheme) var colorScheme
    private var elementOpacityDark: Double { colorScheme == .dark ? 0.1 : 0.5 }
    private var textOpacity: Double { colorScheme == .dark ? 0.8 : 0.8 }
   
    @StateObject var NotionCaller = ImportUserPage.shared
    
    @State var searchKeywords = String()    //modify text field to search keywords later
  

    var body: some View {
        NavigationView {
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
                    .foregroundStyle(.opacity(textOpacity))
                    
        
                VStack {
                    List(NotionCaller.mainBlockBody, id: \.id) { block in
                        ForEach(block.ExtractedFields, id: \.self) { textField in
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
               
                
                // Navigation Tab Bar
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


