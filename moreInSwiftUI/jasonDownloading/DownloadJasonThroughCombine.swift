//
//  DownloadJasonThroughCombine.swift
//  moreInSwiftUI
//
//  Created by Mac mini on 01/02/2026.
//

import SwiftUI
internal import Combine
struct PostsModel: Identifiable, Codable {
    let userID:Int
    let    id: Int
    let title:String
    let  body: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id
        case title
        case body
    }
}

class SubscriberViewModel: ObservableObject {
    
    @Published var posts: [PostsModel] = []
    var cancellables = Set<AnyCancellable>()
    init() {
        getPosts()
    }
    
    func getPosts() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
            print("Invalid url⁉️")
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
            .decode(type: [PostsModel].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .sink { [weak self] (returnedPosts) in
                self?.posts = returnedPosts
            }
            .store(in: &cancellables)
        func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
            guard
                let response = output.response as? HTTPURLResponse,
                response.statusCode >= 200 && response.statusCode < 300 else {
                throw URLError(.badServerResponse)
            }
            return output.data
        }
    }
}

struct DownloadJasonThroughCombine: View {
    
    @StateObject var vm:SubscriberViewModel = SubscriberViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(vm.posts) { posts in
                    VStack {
                        Text(posts.title.capitalized)
                            .foregroundStyle(.black)
                            .fontWeight(.semibold)
                        
                        
                        Text(posts.body)
                            .foregroundStyle(.gray)
                    }
                }
            }.navigationTitle("download Jason".capitalized)
        }
    }
}

#Preview {
    DownloadJasonThroughCombine()
}
