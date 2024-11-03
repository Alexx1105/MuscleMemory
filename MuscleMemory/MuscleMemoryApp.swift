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
        }
    }
}

#Preview {
    ContainerView()
}
