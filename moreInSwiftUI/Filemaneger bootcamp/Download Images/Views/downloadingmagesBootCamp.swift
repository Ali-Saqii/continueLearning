//
//  downloadingmagesBootCamp.swift
//  moreInSwiftUI
//
//  Created by Mac mini on 06/02/2026.
//

import SwiftUI

struct downloadingmagesBootCamp: View {
    @StateObject var vm = downloadmagesViewModel()
    var body: some View {
        NavigationStack {
            List {
                ForEach(vm.photos) { model in
                 downLoadImageRowView(model: model)
                }
            }
            .navigationTitle("Downloading Photos")
        }
    }
}

#Preview {
    downloadingmagesBootCamp()
}
