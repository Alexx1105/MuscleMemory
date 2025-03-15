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



struct test: View {
    var body: some View {
        
        Button {
            DynamicRepAttribute.staticAttribute.startDynamicRep(titleName: "title here", contentBody: "content body here")
        } label: {
            Rectangle()
                .fill(Color.blue)
                .frame(width: 25, height: 25)
        }
        
        Button {
            DynamicRepAttribute.staticAttribute.updateDynamicRep()
        } label: {
            Rectangle()
            .fill(Color.yellow)
            .frame(width: 25, height: 25)
        }
        
        Button {
            DynamicRepAttribute.staticAttribute.killDynamicRep(titleName: "updated title", contentBody: "updated content")
        } label: {
            Rectangle()
            .fill(Color.red)
            .frame(width: 25, height: 25)
        }
    }
}

#Preview {
    test()
}
