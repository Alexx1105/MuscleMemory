//
//  MainMenu.swift
//  MuscleMemory
//
//  Created by alex haidar on 10/21/24.
//

import SwiftUI
import Foundation

struct MainMenu: View {
    @State var searchKeywords = String()    //modify text field to search keywords later
    @Environment(\.colorScheme) var colorScheme
    private var elementOpacityDark: Double { colorScheme == .dark ? 0.1 : 0.5 }
    private var textOpacity: Double { colorScheme == .dark ? 0.8 : 0.8 }
  
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
                 Spacer()
               
            
        VStack {
            Text("Your notes from Notion:")
                .fontWeight(.semibold)
                .padding(.bottom)
                .frame(maxHeight: .infinity, alignment: .leading)
                .padding(.trailing, 150)
                .opacity(textOpacity)
               
            }
        .padding(.bottom, 490)
           
           
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
