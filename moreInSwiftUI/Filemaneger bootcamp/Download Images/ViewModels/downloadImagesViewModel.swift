//
//  downloadImagesViewModel.swift
//  moreInSwiftUI
//
//  Created by Mac mini on 06/02/2026.
//

import Foundation
internal import Combine

class downloadmagesViewModel: ObservableObject {
    var cancellables = Set<AnyCancellable>()

    @Published var photos: [PhotoModel] = []
    let dataService = PhotoModelDataService.instance
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        dataService.$photoModel
        .sink{ [weak self] (returnedDataModel) in
            self?.photos = returnedDataModel
            
        }
        .store(in: &cancellables)
    }
}
