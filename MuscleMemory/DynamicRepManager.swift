//
//  DynamicRepManager.swift
//  MuscleMemory
//
//  Created by alex haidar on 3/9/25.
//

import ActivityKit
import Foundation
import OSLog
import Supabase


@MainActor
class DynamicRepAttribute {
    
    struct TimeStamps: Encodable {
        let token: String
        let last_sent: Date
    }
    
    static let staticAttribute = DynamicRepAttribute()
    var staticActivity: Activity<DynamicRepAttributes>?
    
    let supabaseDBClient = SupabaseClient(supabaseURL: URL(string: "https://oxgumwqxnghqccazzqvw.supabase.co")!,
                                          supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im94Z3Vtd3F4bmdocWNjYXp6cXZ3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDc0MTE0MjQsImV4cCI6MjA2Mjk4NzQyNH0.gt_S5p_sGgAEN1fJSPYIKEpDMMvo3PNx-pnhlC_2fKQ")
    
    func startDynamicRep(plain_text: String?, userContentPage: String?) {   //we are defining attributes for DynamicRep content here aswell as debug related tasks for dynamic island
        if ActivityAuthorizationInfo().areActivitiesEnabled {
            
            let activityAttributes = DynamicRepAttributes()
            let initialState = DynamicRepAttributes.ContentState(plain_text: plain_text, userContentPage: userContentPage)
            
            do {
                let start = try Activity<DynamicRepAttributes>.request(attributes: activityAttributes, content: .init(state: initialState, staleDate: nil), pushType: .token)
                print("activity started: \(start.id)")
                
                Task {
                    for await pushToken in start.pushTokenUpdates {
                        let formatPushToken = pushToken.reduce("") {
                            $0 + String(format: "%02x", $1)
                        }
                        Logger().log("new push token created: \(formatPushToken)")
                        
                        let formatTimeStamp = TimeStamps(token: formatPushToken, last_sent: Date())
                        let sendToken = try! await supabaseDBClient.from("push_tokens").insert(["token": formatTimeStamp]).select("token").execute()
                       
                        Logger().log("push token successfully sent up to Supabase: \(String(describing:(sendToken)))")       //wrapped in String describing: because .execute() doesn't work with CustomStringConvertible
                        Logger().log("TIME STAMP: \(String(describing:(formatTimeStamp)))")
                    }
                }
                
            } catch {
                print("activity attribute could not started: \(error)")
            }
        }
    }
    
    func updateDynamicRep(plain_text: String?, userContentPage: String?) {
        guard let updateActivity = staticActivity else { return }
        let updatedState = DynamicRepAttributes.ContentState(plain_text: plain_text, userContentPage: userContentPage)
        
        Task {
            await updateActivity.update(ActivityContent(state: updatedState, staleDate: nil))
            print("activity is being successfully updated :D\(updateActivity.id)")
        }
    }
    
    @MainActor
    func killDynamicRep(plain_text: String?, userContentPage: String?) {
        guard let endActivity = staticActivity else { return }
        let endState = DynamicRepAttributes.ContentState(plain_text: plain_text, userContentPage: userContentPage)
        
        Task {
            await endActivity.end(ActivityContent(state: endState, staleDate: .now), dismissalPolicy: .immediate)
            print("activity is being successfully ended ❌ \(endActivity.id)")
        }
        print("end activity successfully ended on main thread")
        
    }
}

