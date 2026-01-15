//
//  magnifiationGesture.swift
//  moreInSwiftUI
//
//  Created by Mac mini on 30/12/2025.
//

import SwiftUI

struct magnifiationGesture: View {
    @State private var scale: CGFloat = 1.0
    
    var body: some View {
        Image("placeholderImagee")
            .resizable()
            .scaledToFit()
            .scaleEffect(scale)
            .gesture(
                MagnificationGesture()
                    .onChanged { value in
                        scale = value
                    }
            )
    }
}
struct magnification: View {
    @State private var scale: CGFloat = 1.0
    @State private var lastScale: CGFloat = 1.0

    var body: some View {
        Image(systemName: "photo")
            .resizable()
            .scaledToFit()
            .scaleEffect(scale)
            .gesture(
                MagnificationGesture()
                    .onChanged { value in
                        scale = lastScale * value
                    }
                    .onEnded { _ in
                        withAnimation(.spring(duration: 0.4)) {
                            
                            scale = lastScale
                        }
                    }
            )
    }
}

#Preview {
//    magnifiationGesture()
    magnification()
}
