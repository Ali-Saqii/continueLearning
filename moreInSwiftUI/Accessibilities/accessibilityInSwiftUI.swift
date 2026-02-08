//
//  accessibilityInSwiftUI.swift
//  moreInSwiftUI
//
//  Created by Mac mini on 07/02/2026.
//

import SwiftUI

struct accessibilityInSwiftUI: View {
    @Environment(\.dynamicTypeSize) var size
    var body: some View {
        NavigationStack {
            List {
                ForEach( 0..<10) { _ in
                    VStack(alignment:.leading,spacing: 8) {
                        HStack {
                            Image(systemName: "heart.fill")
                                .accessibilityHidden(true)
                            Text("Salam Pakistan")
                        }.font(.title)
                        Text("ghyghjfds fhdsbhdfsd hdsfhdsfhg dfhh dsfhds hf")
                            .font(.subheadline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .lineLimit(3)
                            .minimumScaleFactor(size.currentMinimumScaleFactor)
                    }.background(.red)
                        .accessibilityElement(children: .combine)
                        .accessibilityLabel("Salam Pakistan.ghyghjfds fhdsbhdfsd hdsfhdsfhg dfhh dsfhds hf")
                }
            }.listStyle(PlainListStyle())
                .navigationTitle("Accessabilities")
        }
    }
}
extension DynamicTypeSize {
    var currentMinimumScaleFactor: CGFloat {
        switch self {
        case .xSmall , .small,.medium:
            return 1.0
        case .large, .xxLarge,.xLarge:
            return 0.8
        default:
            return 0.6
        }
    }
}

#Preview {
    accessibilityInSwiftUI()
}
