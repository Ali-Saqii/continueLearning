//
//  hashableProtocols.swift
//  moreInSwiftUI
//
//  Created by Mac mini on 08/01/2026.
//

import SwiftUI
internal import Combine

struct item: Hashable/*Identifiable*/ {
//    let id = UUID().uuidString
    let name : String
    func hash(into hasher: inout Hasher) {
           hasher.combine(name)
       }
}

class itemViewModel: ObservableObject {
  
    
    
    @Published var items : [item] = [
        item(name:"hassan"),
        item(name:"hassan"),
        item(name:"hassan"),
        item(name:"hassan"),
        item(name:"hassan"),
    
    ]
}

struct hashableProtocols: View {
    @StateObject var itemsView:itemViewModel = itemViewModel()
    var body: some View {
        ForEach(itemsView.items,id: \.self) { items in
            Text(items.hashValue.description)
            Text(items.name)
            
        }
    }
}

#Preview {
    hashableProtocols()
}
