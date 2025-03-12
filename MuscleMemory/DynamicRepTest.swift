//
//  test.swift
//  MuscleMemory
//
//  Created by alex haidar on 3/10/25.
//

import SwiftUI
import Foundation
import ActivityKit



struct test: View {
    var body: some View {
        
        
        Button {
            
#if !DEBUG_PREVIEW
            DynamicRepAttribute.staticAttribute.startDynamicRep(titleName: "title here", contentBody: "content body here")
#else
            print("could not run")
#endif
            
        } label: {
            Rectangle()
                .frame(width: 25, height: 25)
        }
        
    }
}
#Preview {
    test()
}
