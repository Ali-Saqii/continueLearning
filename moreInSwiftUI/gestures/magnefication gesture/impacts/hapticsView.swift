//
//  hapticsView.swift
//  moreInSwiftUI
//
//  Created by Mac mini on 07/01/2026.
//

import SwiftUI
enum HapticEvent {
    case tap
    case success
    case error
}
struct hapticsView: View {
    
    @State private var haptic: HapticEvent?
    
    var body: some View {
        VStack {
            Button("error", action: {HapticManeger.instance.notification(type: .error)})
            Button("success", action: {HapticManeger.instance.notification(type: .success)})
            Button("warning", action: {HapticManeger.instance.notification(type: .warning)})
            
            Divider()
            
            Button("rigid", action: {HapticManeger.instance.impact(type: .rigid)})
            Button("light", action: {HapticManeger.instance.impact(type: .light)})
            Button("medium", action: {HapticManeger.instance.impact(type: .medium)})
            Button("soft", action: {HapticManeger.instance.impact(type: .soft)})
            Button("heavy", action: {HapticManeger.instance.impact(type: .heavy)})
            Button("light", action: {HapticManeger.instance.impact(type: .light)})
            Button("medium", action: {HapticManeger.instance.impact(type: .medium)})
            Divider()
            Text("New appporach in ios 26 recomended")
            Divider()
            Button("Save") {
                haptic = .success
            }
            .sensoryFeedback(.success, trigger: haptic)
            
        }
        
        
    }
}

#Preview {
    hapticsView()
}
