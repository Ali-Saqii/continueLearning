//
//  mask.swift
//  moreInSwiftUI
//
//  Created by Mac mini on 06/01/2026.
//

import SwiftUI

struct mask: View {
    var body: some View {
        LinearGradient(colors: [.purple, .orange], startPoint: .top, endPoint: .bottom)
            .frame(width: 300, height: 100)
            .mask(
                Text("SWIFTUI")
                    .font(.system(size: 60, weight: .black))
            )
    }
}
struct mask2: View {
    
    @State var count = 0
    
    var body: some View{
        ZStack{
            starView
                .overlay {
                    overlayView.mask(starView)
                }
        }
    }
    
   
    
    private var overlayView: some View {
        
        GeometryReader { geo in
            
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundStyle(.yellow)
                    .frame(width: CGFloat(count) / 5 * geo.size.width)
            }
            
        }.allowsHitTesting(false)
        
        
    }
    
    
    var starView: some View {

        HStack{
            ForEach(1..<6) { Index in
                Image(systemName: "star.fill")
                    .foregroundStyle(.gray)
                    .font(.title)
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.6)) {
                            count = Index
                        }
                   
                    }
            }
        }
    }
}

#Preview {
    mask2()
}
