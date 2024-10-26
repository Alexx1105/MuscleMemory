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
    
    var body: some View {
       
        VStack {
            TextField("Search keywords", text: $searchKeywords)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity)
                .padding(13)
                .background(RoundedRectangle(cornerRadius: 30).fill(.white))
                .padding()
                 Spacer()
        
        VStack {
            Text("Your notes from Notion:")
                .fontWeight(.semibold)
                .padding(.bottom)
                .frame(maxHeight: .infinity, alignment: .leading)
                .padding(.trailing, 150)
  
               
            }
        .padding(.bottom, 490)
           
           
         VStack {
                Divider()
                    .padding()
                
             HStack {
              
                     Button(action: {              //add functionality later
                     }) {
                         Image("menuButton")
                     }
                     .frame(maxWidth: .infinity)
                     
                     Button(action: {              //add functionality later
                     }) {
                         Image("settingsButton")
                     }
                     .frame(maxWidth: .infinity)
                     
                     Button(action: {
                     }) {
                         Image("notionImportButton")
                     }
                     .frame(maxWidth: .infinity)
                 
                 .padding(.horizontal)
             }
        }
   }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.mmBackground)
       
    }
       
        
}

#Preview {
    MainMenu()
}
