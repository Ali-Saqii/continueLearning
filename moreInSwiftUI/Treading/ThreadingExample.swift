//
//  ThreadingExample.swift
//  moreInSwiftUI
//
//  Created by Mac mini on 27/01/2026.
//

import SwiftUI

// MARK: - Example 1: WRONG WAY (Main Thread Blocking)
struct WrongWayView: View {
    @State private var image: UIImage?
    @State private var isLoading = false
    
    var body: some View {
        VStack(spacing: 20) {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
            } else if isLoading {
                ProgressView("Loading...")
            } else {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 200)
            }
            
            Button("Download Image (Wrong Way)") {
                downloadImageWrongWay()
            }
            .buttonStyle(.borderedProminent)
            
            Text("⚠️ UI will freeze!")
                .foregroundColor(.red)
                .font(.caption)
        }
        .padding()
    }
    
    // ❌ GALAT TARIKA - Main thread block hoga
    func downloadImageWrongWay() {
        isLoading = true
        
        // Yeh MAIN THREAD par chal raha hai! ❌
        let url = URL(string: "https://picsum.photos/400/300")!
        
        do {
            // ⚠️ Yeh line UI ko 2-3 seconds ke liye FREEZE kar degi
            let data = try Data(contentsOf: url)
            image = UIImage(data: data)
        } catch {
            print("Error: \(error)")
        }
        
        isLoading = false
    }
}

// MARK: - Example 2: CORRECT WAY (Background Thread)
struct CorrectWayView: View {
    @State private var image: UIImage?
    @State private var isLoading = false
    
    var body: some View {
        VStack(spacing: 20) {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
            } else if isLoading {
                ProgressView("Loading...")
            } else {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 200)
            }
            
            Button("Download Image (Correct Way)") {
                downloadImageCorrectWay()
            }
            .buttonStyle(.borderedProminent)
            .tint(.green)
            
            Text("✅ UI stays smooth!")
                .foregroundColor(.green)
                .font(.caption)
        }
        .padding()
    }
    
    // ✅ SAHI TARIKA - Background thread use karo
    func downloadImageCorrectWay() {
        isLoading = true // Main thread par (UI update)
        
        // Step 1: Background thread mein heavy kaam
        DispatchQueue.global(qos: .userInitiated).async {
            
            let url = URL(string: "https://picsum.photos/400/300")!
            
            // Yeh background mein chal raha hai ✅
            // UI freeze nahi hoga
            if let data = try? Data(contentsOf: url),
               let downloadedImage = UIImage(data: data) {
                
                // Step 2: UI update ke liye main thread par wapas aao
                DispatchQueue.main.async {
                    self.image = downloadedImage
                    self.isLoading = false
                }
            } else {
                DispatchQueue.main.async {
                    self.isLoading = false
                }
            }
        }
    }
}

// MARK: - Example 3: MODERN WAY (Async/Await)
struct ModernWayView: View {
    @State private var image: UIImage?
    @State private var isLoading = false
    
    var body: some View {
        VStack(spacing: 20) {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
            } else if isLoading {
                ProgressView("Loading...")
            } else {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 200)
            }
            
            Button("Download Image (Modern Way)") {
                Task {
                    await downloadImageModernWay()
                }
            }
            .buttonStyle(.borderedProminent)
            .tint(.purple)
            
            Text("⭐ Best practice!")
                .foregroundColor(.purple)
                .font(.caption)
        }
        .padding()
    }
    
    // ⭐ MODERN TARIKA - async/await
    func downloadImageModernWay() async {
        isLoading = true
        
        let url = URL(string: "https://picsum.photos/400/300")!
        
        do {
            // Automatically background mein chalta hai
            let (data, _) = try await URLSession.shared.data(from: url)
            
            // Automatically main thread par UI update
            image = UIImage(data: data)
            isLoading = false
            
        } catch {
            print("Error: \(error)")
            isLoading = false
        }
    }
}

// MARK: - Complete Demo View
struct ThreadingDemoView: View {
    var body: some View {
        NavigationStack {
            List {
                Section {
                    NavigationLink("❌ Wrong Way (Blocking)") {
                        WrongWayView()
                    }
                } header: {
                    Text("Main Thread Blocking")
                } footer: {
                    Text("UI will freeze for 2-3 seconds")
                }
                
                Section {
                    NavigationLink("✅ Correct Way (DispatchQueue)") {
                        CorrectWayView()
                    }
                } header: {
                    Text("Background Thread")
                } footer: {
                    Text("UI stays smooth using DispatchQueue")
                }
                
                Section {
                    NavigationLink("⭐ Modern Way (async/await)") {
                        ModernWayView()
                    }
                } header: {
                    Text("Modern Swift Concurrency")
                } footer: {
                    Text("Cleanest approach with async/await")
                }
            }
            .navigationTitle("Threading Examples")
        }
    }
}

#Preview {
    ThreadingDemoView()
}

