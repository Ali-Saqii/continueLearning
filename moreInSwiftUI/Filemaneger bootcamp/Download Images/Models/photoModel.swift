//
//  photoModel.swift
//  moreInSwiftUI
//
//  Created by Mac mini on 06/02/2026.
//

import Foundation

/*
 {
     "albumId": 1,
     "id": 19,
     "title": "perferendis nesciunt eveniet et optio a",
     "url": "https://via.placeholder.com/600/56acb2",
     "thumbnailUrl": "https://via.placeholder.com/150/56acb2"
   }
 */

struct PhotoModel: Identifiable, Codable {
    
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
    
}
