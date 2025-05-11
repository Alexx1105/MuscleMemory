//
//  DynamicRepScheduler.swift
//  MuscleMemory
//
//  Created by alex haidar on 4/21/25.
//

import Foundation



 class DynamicRepScheduler {
    var controlTimer: [Timer] = []
  
      func startTimer(interval: TimeInterval, mode: RunLoop.Mode = .common, handler: @escaping()  -> (Void)) -> Timer {
        let storeTimer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { _ in handler() }
        controlTimer.append(storeTimer)
        return storeTimer
    }

     func stopTimer(storeTimer: Timer) {
         if let stopTimer = controlTimer.firstIndex(of: storeTimer) {
             controlTimer.remove(at: stopTimer)
         
         }
    }
}


