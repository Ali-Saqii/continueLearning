//
//  imageView.swift
//  moreInSwiftUI
//
//  Created by Mac mini on 07/02/2026.
//

import SwiftUI

struct imageView: View {
    @StateObject var loader:imageViewModel
    
    init(url: String) {
        _loader = StateObject(wrappedValue: imageViewModel(url: url))
    }
    
    var body: some View {
        ZStack {
            if loader.isLoading {
                ProgressView()
                    
            }else if let image = loader.image{
                Image(uiImage: image)
                    .resizable()
                    .clipShape(Circle())
            }else {
                Image(systemName: "person.circle.fill")
                    .frame(width: 75, height: 75)
            }
        }
    }
}

#Preview {
    imageView(url:"https://via.placeholder.com/600/92c952")

}
