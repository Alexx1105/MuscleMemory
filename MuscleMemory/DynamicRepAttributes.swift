//
//  DynamicRepAttributes.swift
//  MuscleMemory
//
//  Created by alex haidar on 2/12/25.
//CURRENT WIP

import Foundation
import ActivityKit



public struct DynamicRepAttributes: ActivityAttributes {
    typealias DynamicRepContent = ContentState       //describes live activity
    
    public struct ContentState: Codable, Hashable, Identifiable {
        public var userPageContent: String?
        public var id = UUID()
        
    }
}
    //private func previewContext(Self.ContentState, isStale: Bool, viewKind: ActivityPreviewViewKind) -> Some View {           //preview context
        
    //}
    

