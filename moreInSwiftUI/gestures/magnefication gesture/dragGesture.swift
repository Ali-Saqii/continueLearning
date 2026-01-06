//
//  dragGesture.swift
//  moreInSwiftUI
//
//  Created by Mac mini on 30/12/2025.
//

import SwiftUI

struct dragGesture: View {
    
    @State private var offset: CGSize = .zero
    @State private var lastOffset: CGSize = .zero
    
    
    var body: some View {
        Circle()
            .fill(
                LinearGradient(colors: [Color.red,Color.orange],
                               startPoint: .leading,
                               endPoint: .trailing)
            )
            .frame(width: 100, height: 100)
            .offset(offset)
            .gesture(
                DragGesture()
                
                    .onChanged { value in
                        withAnimation(.spring) {
                            
                            offset = value.translation
                        }
                        
                    }
                    .onEnded { _ in
                        withAnimation(.spring) {
                            
                            offset = lastOffset      // here last off set is equals to zero so it bounce back to its real position
                            
                            //                                lastOffset = offset  // here value of last off set is equals to  off set so when drag end it reamin at same place
                        }
                    }
            )
            .background(
                Circle()
                    .fill(Color.gray)
            )
        
    }
}

private struct DragGesture2: View {
    
    @State private var offset: CGSize = .zero
    
    var body: some View {
        
        ZStack {
            VStack {
                Text("Offset: \(Int(offset.width))")
                Spacer()
            }
            
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.blue)
                .frame(width: 300, height: 500)
                .offset(offset)
                .scaleEffect(getScaleAmount())
                .rotationEffect(.degrees(getRotationAmount()))
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            offset = value.translation   // ✅ NO animation here
                        }
                        .onEnded { _ in
                            withAnimation(.spring(response: 0.4,
                                                  dampingFraction: 0.8)) {
                                offset = .zero
                            }
                        }
                )
                .animation(.interactiveSpring(), value: offset) // ✅ smooth live updates
        }
    }
    
    
    // MARK: - Helpers
    
    private func getScaleAmount() -> CGFloat {
        let maxDrag = UIScreen.main.bounds.width / 2
        let progress = min(abs(offset.width) / maxDrag, 1)
        return 1.0 - progress * 0.15   // ✅ subtle scale
    }
    
    private func getRotationAmount() -> Double {
        let maxDrag = UIScreen.main.bounds.width / 2
        let progress = offset.width / maxDrag   // ❗ signed value
        return Double(progress) * 10             // ±10 degrees
    }
}


#Preview {
    DragGesture2()
}
