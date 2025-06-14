//
//  LocalNotifications.swift
//  MuscleMemory
//
//  Created by alex haidar on 3/6/25.
//CURRENT WIP re-started 5/14/2025

import Foundation
import UserNotifications


@MainActor
public class LocalDynamicRepNotification: ObservableObject {
    public static let notificationContent = LocalDynamicRepNotification()

     let repeatEvent = UNTimeIntervalNotificationTrigger(timeInterval: 64 , repeats: false)
     let id = UUID().uuidString
     
     let pageNotes = searchPages.shared
     let notification = UNMutableNotificationContent()
     
     public init() {
         if let unwrapTitleVal = pageNotes.displaying?.plain_text {
             print("notification title: \(unwrapTitleVal)")
             
             notification.title = unwrapTitleVal
             notification.body = "testing"    // TO-DO: replace with actual content later
             notification.sound = .defaultCritical   //TO-DO: make a custom sound unique to MuscleMemory maybe?
             
             let request = UNNotificationRequest(identifier: id, content: notification, trigger: repeatEvent)
             UNUserNotificationCenter.current().add(request) { error in
                 if let requestError = error {
                     print("notification request could not be sent:\(requestError)")
                 }
             }
         }
     }
}
