//
//  SearchView.swift
//  moreInSwiftUI
//
//  Created by Mac mini on 02/02/2026.
//

import SwiftUI
internal import Combine

private class SearchViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var results: [String]  = []
    
    private var cancellables = Set<AnyCancellable>()
    
    init(){
//        subscribeSearch()
    }
    // Yahan hum manually subscribe kar rahe hain
    func subscribeSearch() {
        $searchText
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] searchQuery in
                // yeh subscriber ha jo val;ues ko recive karta ha
                guard self != nil else {return}
                self?.performSearch(query: searchQuery)
            }
            .store(in: &cancellables)
    }
    func performSearch(query: String) {
        // actuasl search logic yaha hogii
        if query.isEmpty{
            results = []
        }else {
            results.append(query)
        }
    }
}

private struct SearchView: View {
    @StateObject var viewModel = SearchViewModel()
    var body: some View {
        VStack {
              TextField("Search karo...", text: $viewModel.searchText)
                .padding()
                .frame(height:60)
                  .background(.gray.opacity(0.6))
                  .cornerRadius(10)
                  .padding()
                  
            Button("search") {
                viewModel.subscribeSearch()
                viewModel.searchText = ""
            }.buttonStyle(.bordered)
              
              List(viewModel.results, id: \.self) { result in
                  Text(result)
              }
          }
    }
}

#Preview {
    SearchView()
}
