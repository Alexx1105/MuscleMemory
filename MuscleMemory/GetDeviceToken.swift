//
//  GetDeviceToken.swift
//  MuscleMemory
//
//  Created by alex haidar on 2/16/25.

//
//CURRENT WIP not needed as of 2/27/2025 re-started 5/14/2025



import Foundation
import UIKit
import UserNotifications


@MainActor
class GetDeviceToken {
  
    func registerDevice(_ application: UIApplication, didFinishLaunchingWithOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UIApplication.shared.registerForRemoteNotifications()
        return true
    }
    
    func recievedDeviceToken(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data ) {
        self.sendDeviceTokenToServer(data: deviceToken)
    }
    
    func tokenExchangeError(_ application: UIApplication,  didFailToRegisterForRemoteNotificationsWithError error: Error) {
        
    }
    
    private func sendDeviceTokenToServer(data: Data) {
        let convertTokenToString = data.map {String(format: "%02.2hhx", $0)}.joined()
        print("token was converted\(convertTokenToString)")
        
    }
}
