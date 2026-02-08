//
//  visualEffects.swift
//  moreInSwiftUI
//
//  Created by Mac mini on 08/02/2026.
//

import SwiftUI

struct visualEffects: View {
    //    @State private var showSpacer: Bool = false

    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                ForEach(0..<100) { index in
                    Rectangle()
                        .frame(width: 300, height: 200)
                        .frame(maxWidth: .infinity)
                        .background(.orange)
                        .visualEffect{ content, geometry in
                            content.offset(x: geometry.frame(in: .global).minY * 0.3)
                        }
                }
            }
        }
        //        VStack {
        //            Text("Hello world asdjf ;lkasjdf l;aksdjf l;askdfj asl;dkfj a;sldf !")
        //                .padding()
        //                .background(Color.red)
        //                .visualEffect { content, geometry in
        //                    content
        //                        .grayscale(geometry.frame(in: .global).minY < 300 ? 1 : 0)
        //    //                    .grayscale(geometry.size.width >= 200 ? 1 : 0)
        //                }
        //
        //            if showSpacer {
        //                Spacer()
        //            }
        //        }
        //        .animation(.easeIn, value: showSpacer)
        //        .onTapGesture {
        //            showSpacer.toggle()
        //        }
    }
}

#Preview {
    visualEffects()
}
