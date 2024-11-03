//
//  ContentView.swift
//  MuscleMemory
//
//  Created by alex haidar on 4/13/24.
//

import SwiftUI
import Foundation




struct ContentView: View {

    
    @StateObject var NotionCaller = NotionCall()   //manage lifecycle of instance
    
    @State var searchKeywords = String()    //modify text field to search keywords later
    
    @State var menuFunc = String()   //modify to take user back to menu later
    @State var notificationSettings = String() //modify to take user to notifications settings page later
    @State var importNotionFile = String() //modify for user to be able to import their notion file for parsing
    
    
    

    var body: some View {
        NavigationView {
            VStack {
                
                // Search Bar
                TextField("Search keywords", text: $searchKeywords)  //change font later
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .padding(13)
                    .background(RoundedRectangle(cornerRadius: 30).fill(.white))
                    .padding()
                
                // List of Data
                VStack {
                    List(NotionCaller.extractedContent, id: \.id) { block in
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
            .onAppear {
                NotionCaller.makeAPIRequest()
                
            }
            
        }
                  
            }
        }
    



#Preview {
    ContentView()
}


