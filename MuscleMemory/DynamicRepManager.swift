//
//  DynamicRepManager.swift
//  MuscleMemory
//
//  Created by alex haidar on 3/9/25.
//

import ActivityKit
import Foundation



@MainActor
class DynamicRepAttribute {
    static let staticAttribute = DynamicRepAttribute()
    var staticActivity: Activity<DynamicRepAttributes>?
    
    
    func startDynamicRep(plain_text: String?, userContentPage: String?) {   //we are defining attributes for DynamicRep content here aswell as debug related tasks for dynamic island
        if ActivityAuthorizationInfo().areActivitiesEnabled {
            
            let activityAttributes = DynamicRepAttributes(plain_text: plain_text, userContentPage: userContentPage)
            let initialState = DynamicRepAttributes.ContentState()
            
            do {
                let start = try Activity<DynamicRepAttributes>.request(attributes: activityAttributes, content: .init(state: initialState, staleDate: nil), pushType: nil)
                print("activity started: \(start.id)")
            } catch {
                print("activity attribute could not started: \(error)")
            }
        }
    }
    
    func updateDynamicRep(plain_text: String?, userContentPage: String?) {
            guard let updateActivity = staticActivity else { return }
            let updatedState = DynamicRepAttributes.ContentState()
            
            Task {
                await updateActivity.update(ActivityContent(state: updatedState, staleDate: nil))  
                print("activity is being successfully updated :D\(updateActivity.id)")
            }
        }
        
        func killDynamicRep(plain_text: String?, userContentPage: String?) {
            guard let endActivity = staticActivity else { return }
            let endState = DynamicRepAttributes.ContentState()
            
            Task {
                await endActivity.end(ActivityContent(state: endState, staleDate: nil), dismissalPolicy: .immediate)
                print("activity is being successfully ended ❌ \(endActivity.id)")
            }
        }
    }

