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
    
    
    func startDynamicRep(titleName: String?, contentBody: String?) {   //we are defining attributes for DynamicRep content here aswell as debug related tasks for dynamic island
        if ActivityAuthorizationInfo().areActivitiesEnabled {
            
            let activityAttributes = DynamicRepAttributes(titleName: titleName, contentBody: contentBody)
            let initialState = DynamicRepAttributes.ContentState()  //TO-DO:  add initial state content later
            
            do {
                let start = try Activity<DynamicRepAttributes>.request(attributes: activityAttributes, content: .init(state: initialState, staleDate: nil), pushType: nil)
                print("activity started: \(start.id)")
            } catch {
                print("activity attribute could not started: \(error)")
            }
        }
    }
    
    func updateDynamicRep(titleName: String?, contentBody: String?) {
        
    }
    
    func killDynamicRep(titleName: String?, contentBody: String?) {
        
    }
}
