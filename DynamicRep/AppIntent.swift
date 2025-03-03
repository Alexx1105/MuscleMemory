//
//  AppIntent.swift
//  DynamicRep
//
//  Created by alex haidar on 3/3/25.
//

import WidgetKit
import AppIntents
import Foundation
import UserNotifications



@MainActor
 class LocalDynamicRepNotification {
     
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
