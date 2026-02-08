//
//  PhotoModelDataService.swift
//  moreInSwiftUI
//
//  Created by Mac mini on 07/02/2026.
//

import Foundation
internal import Combine

class PhotoModelDataService {
    
    static let instance = PhotoModelDataService()
    @Published var photoModel: [PhotoModel] = []
    var cancellables = Set<AnyCancellable>()
    
    private init() {
        downloadData()
    }
    
    func downloadData() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/photos") else {
            print("in valid url")
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutPut)
            .decode(type: [PhotoModel].self, decoder: JSONDecoder())
            .sink { (completion) in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error downloading data. \(error)")
                }
            } receiveValue: { [weak self] (returnedPhotoModels) in
                self?.photoModel = returnedPhotoModels
            }
            .store(in: &cancellables)
    }
        private func handleOutPut(outPut: URLSession.DataTaskPublisher.Output) throws -> Data {
            guard
                let response = outPut.response as? HTTPURLResponse,
                response.statusCode >= 200 && response.statusCode < 300 else {
                throw URLError(.badServerResponse)
            }
            return outPut.data
        }
    }

