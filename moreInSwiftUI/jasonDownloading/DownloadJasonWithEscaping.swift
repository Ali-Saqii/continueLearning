//
//  DownloadJasonWithEscaping.swift
//  moreInSwiftUI
//
//  Created by Mac mini on 30/01/2026.
//

import SwiftUI
internal import Combine

struct PostModel: Identifiable, Codable {
    let userID, id: Int
    let title, body: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, body
    }
}
class DownloadWithEscapingViewModel: ObservableObject {
    @Published var posts: [PostModel] = []
    
    init() {
        getPosts()
    }
    
    func getPosts() {
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts")
                
        else {
            print("Invalid url")
            return
        }
        downloadData(fromURL: url) { (returnedData) in
            if let data = returnedData {
                guard let newPost = try? JSONDecoder().decode([PostModel].self, from: data) else { return }
                
                DispatchQueue.main.async { [weak self] in
                    self?.posts = newPost
                }
            } else {
                print("no data returned")
            }
        }
    }

    /*
//        URLSession.shared.dataTask(with: url) { (data, response, error) in
//            guard
//                let data = data,
//                error == nil,
//                let response = response as? HTTPURLResponse,
//                response.statusCode >= 200 && response.statusCode < 300
//            else {
//                print("Error while while downloading data")
//                return
//            }
//            guard error == nil else {
//                print("error downloading: \(error)")
//                return
//            }
//            
//            guard let response = response as? HTTPURLResponse else {
//                print("invalid response")
//                return
//            }
//            guard response.statusCode >= 200 && response.statusCode < 300 else {
//                print("statuscode should be 2xx,but it is \(response.statusCode)")
//                return
//            }
//            
//            print("Sucessfully downloaded data")
//            let jasonString = String(data: data, encoding: .utf8)
//            print(jasonString ?? "gdfgdf")
//            
//            guard let newPost = try? JSONDecoder().decode(PostModel.self, from: data) else { return }
//            
//            DispatchQueue.main.async { [weak self] in
//                self?.posts.append(newPost)
     */  // longer version of this codew
    
    func downloadData(fromURL url: URL, completionHandler: @escaping (_ data: Data?)-> ()) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard
                let data = data,
                error == nil,
                let response = response as? HTTPURLResponse,
                response.statusCode >= 200 && response.statusCode < 300
            else {
                print("Error while while downloading data")
                completionHandler(nil)
                return
            }
            
            completionHandler(data)
        }.resume()
    }
}

struct DownloadJasonWithEscaping: View {
    
    @StateObject var vm : DownloadWithEscapingViewModel = DownloadWithEscapingViewModel()
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
    DownloadJasonWithEscaping()
}
