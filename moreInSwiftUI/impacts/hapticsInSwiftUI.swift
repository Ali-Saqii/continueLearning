//
//  hapticsInSwiftUI.swift
//  moreInSwiftUI
//
//  Created by Mac mini on 07/01/2026.
//

import Foundation
import SwiftUI
class HapticManeger {
    
    static let instance = HapticManeger()
    
    
    func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    
    func impact (type: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator()
        generator.impactOccurred()
    }
}
