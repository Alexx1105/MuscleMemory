//
//  test.swift
//  MuscleMemory
//
//  Created by alex haidar on 3/10/25.
//
//FOR TESTING/DEBUGGING PURPOSES ONLY

import SwiftUI
import Foundation
import ActivityKit
import KimchiKit


struct test: View {
    var body: some View {
        
#if DEBUG
      Button("Start Local Live Activity") {
          if #available(iOS 16.1, *) {
              debugStartDynamicRepLiveActivity()
          }
      }
      #endif
        
        
    }
}

#Preview {
    test()
}
