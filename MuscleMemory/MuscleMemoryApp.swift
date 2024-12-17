//
//  MuscleMemoryApp.swift
//  MuscleMemory
//
//  Created by alex haidar on 4/13/24.
//

import SwiftUI
import AuthenticationServices


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
                        if let codeParse = parseCodeQuery.queryItems?.first(where: {$0.name == "codeParse" })?.value {
                            print("code Query recieved and parsed\(parseCodeQuery)")
                            
                            let pages = userPages()
                            Task {
                                do {
                                    try await exchangeToken(authorizationCode: codeParse)
                                    try await pages.userEndpoint()
                                    
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
    }
}

#Preview {
    ContainerView()
}
