//
//  RotationGesture.swift
//  moreInSwiftUI
//
//  Created by Mac mini on 30/12/2025.
//

import SwiftUI

struct RotationGestur: View {
    
    @State private var rotation: Angle = .zero
    @State private var lastRotation: Angle = .zero
    

    var body: some View {
        Image(systemName: "arrow.2.circlepath")
            .resizable()
            .frame(width: 200, height: 200)
            .rotationEffect(rotation)
            .gesture(
                RotationGesture()
                    .onChanged { value in
                        rotation = lastRotation + value
                    }
                    .onEnded { _ in
                        lastRotation = rotation
                    }
            )
    }
}

#Preview {
    RotationGestur()
}
