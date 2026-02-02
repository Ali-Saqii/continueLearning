//
//  TimerView.swift
//  moreInSwiftUI
//
//  Created by Mac mini on 03/02/2026.
//

import SwiftUI
internal import Combine

struct TimerView: View {
    @State private var currentTime = Date()
    @State private var counter = 0
    
    let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            Text("Time: \(currentTime.formatted(date: .omitted, time: .standard))")
            Text("Counter: \(counter)")
        }
        // .onReceive View ke andar use ho raha hai
        .onReceive(timer) { date in
            // Yahan value receive ho rahi hai
            currentTime = date
            counter += 1
        }
        // .store(in:) ki zaroorat NAHI - SwiftUI khud manage karta hai
    }
}

#Preview {
    TimerView()
}
