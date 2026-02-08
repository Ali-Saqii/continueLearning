//
//  downLoadImageRowView.swift
//  moreInSwiftUI
//
//  Created by Mac mini on 07/02/2026.
//

import SwiftUI

struct downLoadImageRowView: View {
    let model : PhotoModel
    var body: some View {
        HStack {
            imageView(url:model.url)
                .frame(width: 75, height: 75)
            VStack(alignment: .leading) {
                Text(model.title)
                    .font(.headline)
                Text(model.url)
                    .foregroundStyle(.gray)
                    .italic()
                
            }
            .frame(maxWidth: .infinity,alignment: .leading)
        }
    }
}

#Preview {
    downLoadImageRowView(model:PhotoModel(albumId: 1, id: 1, title: "dfgdf", url: "https://via.placeholder.com/600/f9cee5", thumbnailUrl: "https://via.placeholder.com/600/f9cee5" )
        )
}
//    "url": "https://via.placeholder.com/600/f9cee5",

