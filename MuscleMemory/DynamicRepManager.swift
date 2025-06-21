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
    
    static let staticAttribute = DynamicRepAttribute()
    var staticActivity: Activity<DynamicRepAttributes>?
    
    func startDynamicRep(plain_text: String?, userContentPage: [String?]) {
        let titleChunk = plain_text ?? ""
        let chunkTitle = [titleChunk]
        let chunkTitleFirst = chunkTitle.first
        
        if ActivityAuthorizationInfo().areActivitiesEnabled {
        
            let activityAttributes = DynamicRepAttributes()
            let initialState = DynamicRepAttributes.ContentState(plain_text: chunkTitleFirst, userContentPage: userContentPage)
      
          
            do {
                let start = try Activity<DynamicRepAttributes>.request(attributes: activityAttributes, content: .init(state: initialState, staleDate: nil), pushType: .token)
                print("activity started: \(start.id)")
                
            } catch {
                print("activity attribute could not started: \(error)")
            }
        }
    }
    
    func updateDynamicRep(plain_text: String?, userContentPage: [String?]) {
        guard let updateActivity = staticActivity else { return }
        let updatedState = DynamicRepAttributes.ContentState(plain_text: plain_text, userContentPage: userContentPage)
        
        Task {
            await updateActivity.update(ActivityContent(state: updatedState, staleDate: nil))
            print("activity is being successfully updated :D\(updateActivity.id)")
        }
    }
    
    @MainActor
    func killDynamicRep(plain_text: String?, userContentPage: [String?]) {
        guard let endActivity = staticActivity else { return }
        let endState = DynamicRepAttributes.ContentState(plain_text: plain_text, userContentPage: userContentPage)
        
        Task {
            await endActivity.end(ActivityContent(state: endState, staleDate: .now), dismissalPolicy: .immediate)
            print("activity is being successfully ended ❌ \(endActivity.id)")
        }
        print("end activity successfully ended on main thread")
        
    }
}

