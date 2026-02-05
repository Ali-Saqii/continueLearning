//
//  filemaneger.swift
//  moreInSwiftUI
//
//  Created by Mac mini on 05/02/2026.
//

import SwiftUI
internal import Combine

class localfilemaneger {
    static let instance = localfilemaneger()
    let folderName = "MyApp_Images"
    init() {
        createFolderIfNeed()
    }

    func createFolderIfNeed() {
        guard
            let path = FileManager
                .default
                .urls(for: .cachesDirectory, in: .userDomainMask)
                .first?
                .appendingPathComponent(folderName)
                .path else {
            return
        }
        if !FileManager.default.fileExists(atPath: path){
            do {
                try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
                print("folder created sucessfully")
            } catch let error {
                print("error\(error.localizedDescription)")
            }
        }
    }

    func saveImagetoFm(image:UIImage, name: String) -> String{
        guard
            let data = image.jpegData(compressionQuality: 1.0),
            let path = getPathForImage(name: name) else {
            print("error getting data")
            return "error getting data"
        }
        /*
//        let directory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
//        let path = directory?.appendingPathComponent("\(name).jpg")
         */
       
        
        do {
            try data.write(to: path)
            print("sucessfully downloaded ✅")
            print(path)
            return "sucessfully downloaded ✅"
        } catch let error{
            print("error while writing data ⁉️ :\(error.localizedDescription)")
            return "error while writing data ⁉️ :\(error.localizedDescription)"
        }
    }
    func getImage(name: String) -> UIImage? {
        guard
            let path = getPathForImage(name: name)?.path,
            FileManager.default.fileExists(atPath: path)else {
            print("file not exixts at this path")
            return nil
        }
        return UIImage(contentsOfFile: path)
    }
    func getPathForImage(name: String) -> URL? {
        guard
            let path = FileManager
                .default
                .urls(for: .cachesDirectory, in: .userDomainMask)
                .first?
                .appendingPathComponent(folderName)
                .appendingPathComponent("\(name).jpg") else {
            print("Error getting path")
            return nil
        }
        return path
    }
    func deleteImageFromFM(name: String) -> String {
        guard
            let path = getPathForImage(name: name),
            FileManager.default.fileExists(atPath: path.path) else {
            print("file not found not found at this path")
            return "file not found not found at this path"
        }
        
        do{
            try FileManager.default.removeItem(at: path)
            print("sucessfully deleted item ")
            return "sucessfully deleted item "
        }catch let error {
            print("Error deleting Image.\(error.localizedDescription)")
            return "Error deleting Image.\(error.localizedDescription)"
        }
    }
    
    func deleteFolder() -> String {
        guard
            let path = FileManager
                .default
                .urls(for: .cachesDirectory, in: .userDomainMask)
                .first?
                .appendingPathComponent(folderName)
                .path else {
            return "folder not found at this path ❌"
        }
        do{
            try FileManager.default.removeItem(atPath: path)
            print("sucess fully deleted folder")
            return "sucess fully deleted folder ✅"
        }catch let error{
            print("Error while deleting folder: \(error.localizedDescription)")
            return "error while deleting folder ❌"
        }
    }
}
class filemanegerViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    let imageName = "Ali"
    let manager = localfilemaneger.instance
    @Published var infoMessage = ""
    init() {
//        getImagefromassestFolder()
    }
    
    func getImagefromassestFolder() {
        image = UIImage(named:imageName)
        infoMessage = "sucessfully get it from assests"
    }
    func saveImage() {
        guard
            let image = image else {
            print("image not found ❗️")
            return
        }
        
       infoMessage =  manager.saveImagetoFm(image: image, name: imageName)
    }
    
    func getImage() {
        image = manager.getImage(name: imageName)
        if image == nil {
            infoMessage = "image not found"
        } else {
            infoMessage = "sucessfully get it"
        }
    }
    func deleteImage() {
        infoMessage = manager.deleteImageFromFM(name: imageName)
}
    func deleteFolder() {
        
        infoMessage = manager.deleteFolder()
    }
}

struct filemaneger: View {
    
    @StateObject var vm = filemanegerViewModel()
    var body: some View {
        NavigationStack {
            VStack {
                if let image = vm.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipped()
                        .cornerRadius(10)
                        .padding()
                }else {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .foregroundStyle(.gray.opacity(0.7))
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipped()
                        .cornerRadius(10)
                        .padding()
                }
                HStack {
                    Button {
                        vm.saveImage()
                    } label: {
                        Text("Save to FM")
                            .foregroundStyle(.white)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .frame(height: 60)
                    }.background(.mint)
                        .cornerRadius(20)
                        .padding(.horizontal,5)
                    Button {
                        vm.getImage()
                    } label: {
                        Text("Get from FM")
                            .foregroundStyle(.white)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .frame(height: 60)
                    }.background(.mint)
                        .cornerRadius(20)
                        .padding(.horizontal,5)
                }
                HStack {
                    Button {
                        vm.getImagefromassestFolder()
                    } label: {
                        Text("Get image from assests")
                            .foregroundStyle(.white)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .frame(height: 60)
                    }.background(.mint)
                        .cornerRadius(20)
                        .padding(.horizontal,5)
                    Button {
                        vm.deleteImage()
                    } label: {
                        Text("Delete image from assests")
                            .foregroundStyle(.white)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .frame(height: 60)
                    }.background(.mint)
                        .cornerRadius(20)
                        .padding(.horizontal,5)
                }
                Button {
                    vm.deleteFolder()
                } label: {
                    Text("Delete image from assests")
                        .foregroundStyle(.white)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .frame(height: 60)
                }.background(.red)
                    .cornerRadius(20)
                    .padding(.horizontal,5)
                Spacer()
     
                Text(vm.infoMessage)
                    .foregroundStyle(.black)
                    .font(.title3)
            
               
            }.navigationTitle("Filemaneger")
            
        }
    }
}

#Preview {
    filemaneger()
}
