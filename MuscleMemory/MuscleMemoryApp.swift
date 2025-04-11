//
//  MuscleMemoryApp.swift
//  MuscleMemory
//
//  Created by alex haidar on 4/13/24.
//

import SwiftUI
import AuthenticationServices
import SwiftData

    

    struct ContainerView: View {
        @StateObject var navigationPath = NavPath.shared
        
        var body: some View {
            
            NavigationStack(path: $navigationPath.path) {
                LaunchScreen()
                    .navigationDestination(for: NavPathItem.self) { navigationPathItem in
                        switch navigationPathItem {
                        case .home:
                            MainMenu()
                        case .settings:
                            SettingsView()
                        case .importPage:
                            NotionImportPageView()
                        case .logOut:
                            SignOutView()
                        case .appearence:
                            LightDarkView()
                        case .importpageUser:
                            ImportedNotes()
                        }
                    }
                }
            }
        }


@main
struct MuscleMemoryApp: App {
    var body: some Scene {
        
        WindowGroup {
            ContainerView()

            
                .onOpenURL { url in
                    if let parseCodeQuery = URLComponents(url: url, resolvingAgainstBaseURL: true ) {
                        if let codeParse = parseCodeQuery.queryItems?.first(where: {$0.name == "code" })?.value {
                            print("code Query recieved and parsed\(parseCodeQuery)")
                           
                            let pageData = ImportUserPage.shared
                            let pages = searchPages.shared
                            let context = OAuthTokens.shared.modelContext
                    
                            //let notif = LocalDynamicRepNotification.notificationContent

                            
                            Task {
                                do {
                                    try await OAuthTokens.shared.exchangeToken(authorizationCode: codeParse, modelContext: context)
                                    try await pages.userEndpoint()
                                    try await pageData.pageEndpoint()
                         
                                    print(pageData.mainBlockBody)
                                    
                                    
                                } catch {
                                    print("failed async operation(s):\(error)")
                                }
                            
                            }
                        } else {
                            print("code query is nil:\(parseCodeQuery)")
                        }
                    }
                }

            }
            .modelContainer(for: UserEmail.self)
        }
    }

#Preview {
    ContainerView()
}
