//
//  ScrollViewReader.swift
//  moreInSwiftUI
//
//  Created by Mac mini on 06/01/2026.
//

import SwiftUI

struct scrollViewReader: View {
    var body: some View {
        ScrollView {
            ScrollViewReader { proxy in
              
                    
                    Button("Scroll to Item 20") {
                        withAnimation(.spring()) {
                            proxy.scrollTo(20, anchor: .center)
                        }
                    }
                    VStack(spacing: 16) {
                        ForEach(0..<50, id: \.self) { index in
                            Text("Item \(index)")
                                .padding()
                                .background(Color.blue.opacity(0.2))
                                .cornerRadius(8)
                                .id(index) // 🔑 required
                        }
                    }
                

            }
            
        }
    }
}
struct scrollViewReader2: View {
    
    @State var textField = ""
    @State var scrollViewIndex = 0
    
    var body: some View {
        
        VStack {
            TextField("enter value", text: $textField)
                .padding()
                .keyboardType(.numberPad)
            Button("Scroll to Item \(scrollViewIndex)") {
                withAnimation(.spring()) {
                    if let index = Int(textField) {
                        scrollViewIndex = index
                    }
                }
            }
            ScrollView {
                ScrollViewReader { proxy in
                    VStack(spacing: 3) {
                        ForEach(0..<50, id: \.self) { index in
                            Text("Item \(index)")
                                .padding()
                                .background(Color.blue.opacity(0.2))
                                .cornerRadius(8)
                                .id(index) // 🔑 required
                        }
                    }.onChange(of: scrollViewIndex) { Value in
                        withAnimation(.spring()){
                            proxy.scrollTo(Value, anchor: .center)
                        }
                    }
                    }
                }
                
            }
        }
    }


struct ScrollToValueView: View {

    @State private var inputValue: String = ""

    let items = Array(1...100)   // Example data

    var body: some View {
        VStack(spacing: 16) {

            // Input + Button
            HStack {
                TextField("Enter number (1–100)", text: $inputValue)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.numberPad)

                Button("go") {
                    handleScroll()
                }
                .buttonStyle(.borderedProminent)
            }
            .padding(.horizontal)

            Divider()

            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack(spacing: 12) {

                        // 🔝 Top anchor
                        Color.clear
                            .frame(height: 1)
                            .id("TOP")

                        ForEach(items, id: \.self) { item in
                            Text("Item \(item)")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue.opacity(0.15))
                                .cornerRadius(10)
                                .id(item) // 🔑 scroll target
                        }
                    }
                    .padding()
                }
//                .onChange(of: inputValue) { _ in
//                    // optional: live validation if needed
//                }
                .onAppear {
                    scrollAction = proxy
                }
            }
        }
    }

    // MARK: - Scroll Logic

    @State private var scrollAction: ScrollViewProxy?

    private func handleScroll() {
        guard let proxy = scrollAction else { return }

        if let number = Int(inputValue),
           items.contains(number) {

            withAnimation(.easeInOut) {
                proxy.scrollTo(number, anchor: .center)
            }

        } else {
            
            withAnimation(.easeInOut) {
                proxy.scrollTo("TOP", anchor: .top)
            }
        }
    }
}

#Preview {
//    scrollViewReader2()
    ScrollToValueView()
}
