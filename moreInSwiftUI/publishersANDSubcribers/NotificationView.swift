//
//  NotificationView.swift
//  moreInSwiftUI
//
//  Created by Mac mini on 03/02/2026.
//

import SwiftUI
internal import Combine

// Example: Notification listener

class NotificationViewModel: ObservableObject {
    @Published var message = "Waiting..."
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        // METHOD 1: .sink use karke (ViewModel mein)
        NotificationCenter.default
            .publisher(for: UIApplication.didBecomeActiveNotification)
            .sink { notification in
                print("App active ho gaya - sink se")
                self.message = "App active (from sink)"
            }
            .store(in: &cancellables) // ZAROORI hai
    }
}

struct NotificationView: View {
    @StateObject var viewModel = NotificationViewModel()
    @State private var viewMessage = "Waiting..."
    
    var body: some View {
        VStack(spacing: 20) {
            Text("ViewModel: \(viewModel.message)")
            Text("View: \(viewMessage)")
        }
//        // METHOD 2: .onReceive use karke (View mein)
//        .onReceive(NotificationCenter.default
//            .publisher(for: UIApplication.didBecomeActiveNotification)) { notification in
//            print("App active ho gaya - onReceive se")
//            viewMessage = "App active (from onReceive)"
//            // .store(in:) ki zaroorat NAHI
//        }
    }
}
#Preview {
    NotificationView()
}
