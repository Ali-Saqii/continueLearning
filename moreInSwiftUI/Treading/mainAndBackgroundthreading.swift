//
//  mainAndBackgroundthreading.swift
//  moreInSwiftUI
//
//  Created by Mac mini on 27/01/2026.
//

import SwiftUI
internal import Combine

class Mistake1ViewModel: ObservableObject {
    @Published var data: String = ""
    // ❌ WRONG

    func loadDataWrong() {
        DispatchQueue.global().async {
            // Background thread mein data fetch
            let fetchedData = self.fetchData()
            
            // ⚠️ GALAT: UI update background thread par!
            self.data = fetchedData  // CRASH or WARNING!
        }
    }
    
    // ✅ CORRECT
    
    func loadDataCorrect() {
        DispatchQueue.global().async {
            let fetchedData = self.fetchData()
            
            DispatchQueue.main.async {
                self.data = fetchedData
            }
        }
    }
    
    private func fetchData() -> String  {
        sleep(2)  // simulate network delay
        return "loaded Data"
    }
}
class Mistake2ViewModel: ObservableObject {
    @Published var count = 0
    
    func incrementWrong() {
        DispatchQueue.global().async {
            
            sleep(5)
            DispatchQueue.main.async {
                self.count += 1
            }
        }
    }
    
    func incrementCorrect() {
        DispatchQueue.global().async { [weak self] in
            sleep(5)
            DispatchQueue.main.async {
                self?.count += 1
            }
        }
    }
}
    class Mistake3ViewModel: ObservableObject {
        @Published var counter = 0
        
        // ❌ WRONG: Race condition
        func incrementWrong() {
            // Multiple threads se same variable access
            for _ in 0..<100 {
                DispatchQueue.global().async {
                    self.counter += 1  // Data corruption possible!
                }
            }
            // Expected: 100, Actual: Random (50-100)
        }
        
        // ✅ CORRECT: Serial queue
        private let serialQueue = DispatchQueue(label: "com.app.serial")
        
        func incrementCorrect() {
            for _ in 0..<100 {
                serialQueue.async {
                    DispatchQueue.main.async {
                        self.counter += 1
                    }
                }
            }
            // Result: Always 100 ✅
        }
    }



struct mainAndBackgroundthreading: View {
    @StateObject private var vm1 = Mistake1ViewModel()
    @StateObject private var vm2 = Mistake2ViewModel()
    @StateObject private var vm3 = Mistake3ViewModel()
    var body: some View {
        
        NavigationStack {
            List {
                Section("Mistake 1: Background UI Update") {
                    Text(vm1.data)
                    Button("Load Wrong ❌") {
                        vm1.loadDataWrong()
                    }
                    Button("Load Correct ✅") {
                        vm1.loadDataCorrect()
                    }
                }
                Section("Mistake 2: Memory Leak") {
                    Text("Count: \(vm2.count)")
                    Button("Increment Wrong ❌") {
                        vm2.incrementWrong()
                    }
                    Button("Increment Correct ✅") {
                        vm2.incrementCorrect()
                    }
                }
                Section("Mistake 3: Race Condition") {
                    Text("Counter: \(vm3.counter)")
                    Button("Test Wrong ❌") {
                        vm3.counter = 0
                        vm3.incrementWrong()
                    }
                    Button("Test Correct ✅") {
                        vm3.counter = 0
                        vm3.incrementCorrect()
                    }
                }

            }.navigationTitle("Common Mistakes")

        }
    }
}

#Preview {
    mainAndBackgroundthreading()
}
