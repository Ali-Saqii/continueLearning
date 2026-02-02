//
//  subscriberinSwiftUI.swift
//  moreInSwiftUI
//
//  Created by Mac mini on 02/02/2026.
//

import SwiftUI
internal import Combine

class subscriberViewModel: ObservableObject {
    
    @Published var messageCount : Int = 0
    @Published var newMessage : String = ""
    
    init () {
        sendMessage()
    }
    
    func sendMessage() {
        messageCount += 1
        newMessage = "Message #\(messageCount) recived! "
    }
}

struct subscriberinSwiftUI: View {
    // state object automatically subscribe ban jati ha
    @StateObject var vM:subscriberViewModel = subscriberViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            // yeh message ko subscribe kar ta ha
            
            Text("Total messages : \(vM.messageCount)")
            Text(vM.newMessage)
                           .foregroundColor(.gray)
                       
                       Button("Send Message") {
                           vM.sendMessage()
                       }
                       .buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    subscriberinSwiftUI()
}
