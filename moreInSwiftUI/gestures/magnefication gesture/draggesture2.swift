//
//  draggesture2.swift
//  moreInSwiftUI
//
//  Created by Mac mini on 31/12/2025.
//

import SwiftUI

struct draggesture2: View {
    @State var  startingOffsetY: CGFloat = UIScreen.main.bounds.height*0.85
    @State var currentDragOffsetY: CGFloat = 0
    @State var endingOffsetY: CGFloat = 0
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [.purple.opacity(0.2), .blue.opacity(0.2)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea(edges: .all)
            LoginView()
                .offset(y: startingOffsetY)
                .offset(y: currentDragOffsetY)
                .offset(y: endingOffsetY)
                .gesture(
                    DragGesture()
                        .onChanged({ value in
                            withAnimation(.spring()) {
                                currentDragOffsetY = value.translation.height
                            }
                        })
                        .onEnded({ value in
                            withAnimation(.spring()) {
                                if currentDragOffsetY < -150 {
                                    endingOffsetY = -startingOffsetY
                                  
                                } else if endingOffsetY != 0 && currentDragOffsetY > 150 {
                                    endingOffsetY = 0
                                  
                                }
                                currentDragOffsetY = 0
                            }
                            
                            
                        })
                ).ignoresSafeArea(edges:.bottom)
                
        }
    }
}


struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                Image(systemName: "chevron.up")
                    .font(.title2)
                    .padding(.top)
                // MARK: - Logo
                Image("book") // Replace with your logo asset name
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .shadow(color: .purple.opacity(0.5), radius: 10, x: 0, y: 5)
                    .padding(.top, 40)
                    .rotationEffect(.degrees(-5))
                    .scaleEffect(1.1)
                    .animation(.spring(), value: UUID())
                
                // MARK: - Title
                Text("Welcome to Khata")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(
                        LinearGradient(
                            colors: [.purple, .blue],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                
                // MARK: - Input Fields
                VStack(spacing: 20) {
                    TextField("Email", text: $email)
                        .padding()
                        .background(Color.white.opacity(0.9))
                        .cornerRadius(12)
                        .shadow(color: .purple.opacity(0.2), radius: 5, x: 0, y: 5)
                        .textInputAutocapitalization(.never)
                        .keyboardType(.emailAddress)
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color.white.opacity(0.9))
                        .cornerRadius(12)
                        .shadow(color: .purple.opacity(0.2), radius: 5, x: 0, y: 5)
                }
                .padding(.horizontal)
                
                // MARK: - Login Button
                NavigationLink(destination: Text("hdfdgsdh")) {
                    Text("Login")
                        .fontWeight(.bold)
                }
                .buttonStyle(GradientButtonStyle(colors: [.blue, .purple]))
                .padding(.horizontal)
                
                // MARK: - Sign Up Link
                NavigationLink("Create New Account", destination: Text("hdfdgsdh"))
                    .foregroundColor(.purple)
                    .padding(.top, 10)
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                LinearGradient(
                    colors: [.purple.opacity(0.7), .blue.opacity(0.7)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .cornerRadius(30)
                .ignoresSafeArea()
            )
        }
    }
}

// MARK: - Gradient Button Style
struct GradientButtonStyle: ButtonStyle {
    let colors: [Color]
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .frame(maxWidth: .infinity)
            .background(
                LinearGradient(colors: colors, startPoint: .topLeading, endPoint: .bottomTrailing)
            )
            .cornerRadius(12)
            .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 5)
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .foregroundColor(.white)
            .animation(.spring(), value: configuration.isPressed)
    }
}


#Preview {
    draggesture2()
}
