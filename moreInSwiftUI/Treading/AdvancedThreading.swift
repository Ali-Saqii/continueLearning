//
//  AdvancedThreading.swift
//  moreInSwiftUI
//
//  Created by Mac mini on 28/01/2026.
//

import SwiftUI
internal import Combine

class dispatchGroupExmple: ObservableObject {
    
    @Published var result = ""
    @Published var isLoading = false
    
    func loadMultipleApis() {
        
        isLoading = true
        
        let group = DispatchGroup()
        
        var userData: String?
        var postData: String?
        var commentsData: String?
        
        group.enter()
        DispatchQueue.global().async {
            sleep(2)
            userData = "user data loaded"
            group.leave()
        }
        
        group.enter()
        DispatchQueue.global().async {
            sleep(2)
            postData = "posta data loaded"
            group.leave()
        }
        
        group.enter()
        DispatchQueue.global().async {
            sleep(2)
            commentsData = "commentes data loaded"
            group.leave()
        }
        
        
        //after copleting each tasks
        group.notify(queue: .main) {
            self.result = """
            All Done! 
            \(userData ?? "")
            \(postData ?? "")
            \(commentsData ?? "")
        """
            
            self.isLoading = false
        }
    }
    
}

class DispatchWorkItemExample: ObservableObject {
    @Published var searchResults = ""
    
    private var searchWorkItem: DispatchWorkItem?
    
    func Search(_ query: String) {
        // cancel previous search
        searchWorkItem?.cancel()
        
        // create new work item
        let workItem = DispatchWorkItem {[weak self] in
            // simulate api call
            sleep(2)
            
            // chec if cancelled
            guard !Thread.current.isCancelled else { return }
            
            DispatchQueue.main.async {
                self?.searchResults = "Results for: \(query)"
            }
        }
        searchWorkItem = workItem
        
        // Execute after delay
        DispatchQueue.global().asyncAfter(deadline:.now() + 3, execute: workItem)
    }
}

class DispatchSemsphoreExample: ObservableObject {
    @Published var downloadstatus = ""
    
    func download() {
        // maximum 3 downloads at a time
        let semaPhore = DispatchSemaphore(value: 3)
        let queue = DispatchQueue.global()
        
        for i in 1...10 {
            queue.async {
                semaPhore.wait()// wait for slot
                DispatchQueue.main.async {
                    self.downloadstatus = "Downloading file \(i) ..."
                    
                }
                
                sleep(2)        //simulate slot
                
                DispatchQueue.main.async {
                    self.downloadstatus = "Completed file \(i)"
                }
                
                semaPhore.signal() // Relaease slot
            }
        }
    }
}

// MARK: Serial vs concurrent Queues
class QueueTypesExample: ObservableObject{
    @Published var serialResult = ""
    @Published var concurrentResult = ""
    
    // serisl Queue one at time
    
}


struct AdvancedThreading: View {
    @StateObject private var groupExample = dispatchGroupExmple()
    @StateObject private var workItemExample = DispatchWorkItemExample()
    var body: some View {
        NavigationStack {
            List {
                Section("DispatchGroup") {
                    if groupExample.isLoading {
                        ProgressView()
                    } else {
                        Text(groupExample.result)
                    }
                    Button("Load Multiple APIs") {
                        groupExample.loadMultipleApis()
                    }
                }
                Section("DispatchWorkItem (Search)") {
                    TextField("Search", text: .constant(""))
                        .onChange(of: "") { newValue in
                            workItemExample.Search(newValue)
                        }
                    Text(workItemExample.searchResults)
                }
            }
        }


    }
}

#Preview {
    AdvancedThreading()
}
