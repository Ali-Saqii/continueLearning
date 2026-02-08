//
//  GeomatryReaders.swift
//  moreInSwiftUI
//
//  Created by Mac mini on 06/01/2026.
//

import SwiftUI

struct GeomatryReaders: View {
    var body: some View {
          GeometryReader { proxy in
              VStack(spacing: 10) {
                  Text("Width: \(Int(proxy.size.width))")
                  Text("Height: \(Int(proxy.size.height))")
                  Rectangle()
                      // Create a rectangle that is 90% of the available width
                      .frame(width: proxy.size.width * 0.9, height: 50)
                      .foregroundColor(.blue)
              }
              .frame(maxWidth: .infinity, maxHeight: .infinity) // Centers the content within the GeometryReader
          }
          .background(Color.gray.opacity(0.1))
      }
  }
#Preview {
    GeomatryReaders()
}
struct GeomatryReaders1: View {
    var body: some View {
          GeometryReader { proxy in
              HStack(spacing: 0) {
//                  Text("Width: \(Int(proxy.size.width))")
//                  Text("Height: \(Int(proxy.size.height))")
                  Rectangle()
                      // Create a rectangle that is 90% of the available width
                      .frame(width: proxy.size.width * 0.666)
                      .foregroundColor(.blue)
                  Rectangle()
                      .foregroundColor(.red)
              }
              .frame(maxWidth: .infinity, maxHeight: .infinity) // Centers the content within the GeometryReader
          }
          .background(Color.gray.opacity(0.1))
      }
  }

    
    // MARK: - DashboardView
    struct DashboardView: View {

        @State private var scrollOffset: CGFloat = 0

        var body: some View {
            ScrollView {

                // 🔹 GeometryReader ONLY for offset detection
                GeometryReader { geo in
                    Color.clear
                        .preference(
                            key: ScrollOffsetPreferenceKey.self,
                            value: geo.frame(in: .named("scroll")).minY
                        )
                }
                .frame(height: 0) // ✅ critical (prevents layout issues)

                VStack(spacing: 16) {

                    headerView

                    ForEach(1...30, id: \.self) { index in
                        rowView(index)
                    }
                }
                .padding()
            }
            .coordinateSpace(name: "scroll")
            .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
                scrollOffset = value
            }
            .navigationTitle("Dashboard")
            .navigationBarTitleDisplayMode(.inline)
        }

        // MARK: - Collapsing Header (Production Pattern)
        private var headerView: some View {
            let height = max(120 - scrollOffset, 80)

            return GeometryReader { geo in
                VStack(alignment: .leading, spacing: 8) {
                    Text("Total Balance")
                        .font(.caption)
                        .foregroundColor(.secondary)

                    Text("PKR 45,000")
                        .font(.title.bold())
                }
                .padding()
                .frame(width: geo.size.width, height: height, alignment: .bottom)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.blue.gradient)
                )
            }
            .frame(height: max(120 - scrollOffset, 80))
            .animation(.easeInOut(duration: 0.25), value: scrollOffset)
        }

        // MARK: - List Row
        private func rowView(_ index: Int) -> some View {
            HStack {
                VStack(alignment: .leading) {
                    Text("Transaction \(index)")
                        .font(.headline)
                    Text("Borrower Payment")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }

                Spacer()

                Text("- PKR \(index * 500)")
                    .font(.subheadline.bold())
                    .foregroundColor(.red)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(.secondarySystemBackground))
            )
        }
    }

    // MARK: - PreferenceKey (Production Safe)
    struct ScrollOffsetPreferenceKey: PreferenceKey {
        static var defaultValue: CGFloat = 0

        static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
            value = nextValue()
        }
    }
#Preview {
    DashboardView()
}
