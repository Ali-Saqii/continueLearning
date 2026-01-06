//
//  longTabGesture.swift
//  moreInSwiftUI
//
//  Created by Mac mini on 29/12/2025.
//

import SwiftUI

struct longTabGesture: View {
    @State private var isPressing = false
    
    @State var ispressing = false
    @State var iSPressingCompleted = false
    
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(maxWidth: isPressing ?.infinity : 0)
            .foregroundStyle(iSPressingCompleted ? .green :.mint)
            .frame(height:30)
            .padding()
        
        HStack() {
            Text("Click Here")
                .foregroundStyle(.white)
                .padding(30)
                .background(.black)
                .cornerRadius(20)
                .onLongPressGesture(minimumDuration: 10) {
                    withAnimation(.easeInOut) {
                        iSPressingCompleted = true
                    }
                    
                }
            onPressingChanged: { pressing in
                if pressing {
                    withAnimation(.easeIn(duration: 1.0)) {
                        ispressing = true
                        print("isPressing : \(ispressing)")
                    }
                } else {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        if !iSPressingCompleted {
                            withAnimation(.easeInOut) {
                                ispressing = false
                            }
                        }
                    }
                }
            }
        
            Text("Reset")
                .foregroundStyle(.white)
                .padding(30)
                .background(.black)
                .cornerRadius(20)
                .onTapGesture {
                    ispressing = false
                    iSPressingCompleted = false
                }
        }

    }
}

private struct longTabDistGesture:View {
    
    @State var isPressed: Bool = false
    
    var body : some View {
        Text("Hold for 1.5 seconds")
            .frame(maxWidth: .infinity)
            .frame(height: 40)
            .background(isPressed ?.mint.opacity(0.4) : .white)
            .cornerRadius(20)
            .padding()
            .onLongPressGesture(
                minimumDuration: 1.5,
                maximumDistance: 20
            ) {
                isPressed.toggle()
                print("Long press completed \n\(isPressed)")
            }
    }
}

#Preview {
    longTabGesture()
    longTabDistGesture()
}
