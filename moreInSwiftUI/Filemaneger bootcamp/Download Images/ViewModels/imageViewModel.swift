//
//  imageViewModel.swift
//  moreInSwiftUI
//
//  Created by Mac mini on 07/02/2026.
//

import Foundation
internal import Combine
import SwiftUI

class imageViewModel: ObservableObject {
    
    @Published var image:UIImage? = nil
    @Published var isLoading = false
    var Cancellables = Set<AnyCancellable>()
    let urlString: String
    init(url:String) {
        urlString = url
        downloadImage()
    }
    
    func downloadImage() {
        isLoading = true
        guard
            let url = URL(string: urlString) else {
            isLoading = false
            return
        }
        URLSession.shared.dataTaskPublisher(for: url)
            .map{UIImage(data: $0.data)}
            .receive(on: DispatchQueue.main)
            .sink {[weak self] (_) in
                self?.isLoading = false
            } receiveValue: {[weak self] (returnedImage) in
                self?.image = returnedImage
            }
            .store(in: &Cancellables)
    }
}
