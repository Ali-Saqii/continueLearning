//
//  cacheBootcamp.swift
//  moreInSwiftUI
//
//  Created by Mac mini on 06/02/2026.
//

import SwiftUI
internal import Combine

class CacheManeger {
    static let instance = CacheManeger()
    
    private init() {}
    
    var imageCache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.countLimit = 100
        cache.totalCostLimit = 1024 * 1024 * 100 // 100mb
        return cache
    }()
    func add(image: UIImage, name: String) -> String {
        imageCache.setObject(image, forKey: name as NSString)
        print("sucessfully added image into cache ✅")
        return "sucessfully added image into cache ✅"
    }
    func remove(name: String) -> String {
        imageCache.removeObject(forKey: name as NSString)
        print("Removed from cache")
        return "Removed from cache"
    }
    func get(name: String) -> UIImage? {
        let image = imageCache.object(forKey: name as NSString)
        print("sucessfully get from cache")
        return image
    }
}


class CacheviewModel:ObservableObject {
    @Published var startingImage: UIImage? = nil
    @Published var cachedImage: UIImage? = nil
    let imageName: String = "ALi"
    var infoMessage = ""
    let manager = CacheManeger.instance

    init() {
        getImageFromAssests()
    }
    func getImageFromAssests() {
        startingImage = UIImage(named: "Ali")
    }
    func saveToCache() {
        if let image = startingImage {
            infoMessage = manager.add(image: image, name: imageName)
        }else {
            infoMessage = "can not save the image"
        }
    }
    func removeFromCache() {
        infoMessage = manager.remove(name: imageName)
    }
    func getFromCache() {
        if let returnedImage = manager.get(name: imageName) {
            cachedImage = returnedImage
            infoMessage = "Got image from Cache"
        } else {
            infoMessage = "Image not found in Cache"
        }
    }
}

struct cacheBootcamp: View {
    
    @StateObject var vm = CacheviewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                if let image = vm.startingImage {
                    Image(uiImage: image)
                        .resizable()
                        .foregroundStyle(.gray.opacity(0.7))
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipped()
                        .cornerRadius(10)
                        .padding()
                } else {
                    Image(systemName:"person.circle.fill")
                        .resizable()
                        .foregroundStyle(.gray.opacity(0.7))
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipped()
                        .cornerRadius(10)
                        .padding()
                }
                Text(vm.infoMessage)
                    .font(.headline)
                    .foregroundColor(.purple)
                HStack(spacing: nil) {
                    Button {
                        vm.saveToCache()
                    } label: {
                        Text("Save to cache")
                            .foregroundStyle(.white)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .frame(height: 60)
                    }.background(.orange)
                        .cornerRadius(20)
                        .padding(.horizontal,5)
                    Button {
                        vm.removeFromCache()
                    } label: {
                        Text("Delete from cache")
                            .foregroundStyle(.white)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .frame(height: 60)
                    }.background(.red)
                        .cornerRadius(20)
                        .padding(.horizontal,5)
                }.padding(.horizontal)
                Button(action: {
                    vm.getFromCache()
                }, label: {
                    Text("Get from Cache")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(10)
                })
                if let image = vm.cachedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipped()
                        .cornerRadius(10)
                }
                Spacer()
            }.navigationTitle("Cache Memory")
        }
    }
}
#Preview {
    cacheBootcamp()
}
