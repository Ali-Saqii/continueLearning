//
//  ScrollViewPagingInSwiftUI.swift
//  moreInSwiftUI
//
//  Created by Mac mini on 09/02/2026.
//

import SwiftUI

struct ScrollViewPagingInSwiftUI: View {
    @State private var scrollPosition: Int? = nil
    var body: some View {
        
        VStack{
            Text("\(scrollPosition ?? 1)")
            Button("SCROLL TO") {
                scrollPosition = (0..<20).randomElement()!
            }
            ScrollView(.horizontal) {
                HStack(spacing: 0) {
                    ForEach(0..<20) { index in
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 300, height: 300)
                            .overlay {
                                Text("\(index)").foregroundStyle(.white)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(10)
                            .id(index)
                            .scrollTransition(.interactive.threshold(.visible(0.9))) { content, phase in
                                content
                                    .opacity(phase.isIdentity ? 1 : 0)
                                    .offset(y: phase.isIdentity ? 0 : -100)
                                    
                            }
                        
                    }
                }.padding(.vertical)
            }.ignoresSafeArea()
                .scrollTargetLayout()
                .scrollTargetBehavior(.viewAligned)
                .scrollBounceBehavior(.basedOnSize)
                .scrollPosition(id: $scrollPosition, anchor: .center)
                .animation(.easeInOut(duration: 0.3), value: scrollPosition)
         
        }
        
        
//        ScrollView(.vertical){
//            VStack {
//                ForEach(0..<20) { index in
//                    Rectangle()
////                        .frame(width: 300, height: 300)
////                        .cornerRadius(20)
//                        .overlay {
//                            Text("\(index)")
//                                .foregroundStyle(.white)
//                        }
//                        .frame(maxWidth: .infinity)
//                        .containerRelativeFrame(.vertical, alignment: .center)
//                }
//            }
//        }.ignoresSafeArea()
//        .scrollTargetLayout()
//        .scrollTargetBehavior(.paging)
//            .scrollBounceBehavior(.basedOnSize)
    }
}

#Preview {
    ScrollViewPagingInSwiftUI()
}
