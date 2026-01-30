//
//  coadableProtocol.swift
//  moreInSwiftUI
//
//  Created by Mac mini on 29/01/2026.
//

import SwiftUI
internal import Combine


//codable =  encodeable + encodeable

struct User: Identifiable , Codable{
    
    let id :String
    let name: String
    let phoneNo: String
    let isPremium: Bool
    let subscribers: Int
    
//    init(id: String, name: String, phoneNo: String, isPremium: Bool, subscribers: Int) {
//        self.id = id
//        self.name = name
//        self.phoneNo = phoneNo
//        self.isPremium = isPremium
//        self.subscribers = subscribers
//    }
//    enum CodingKeys: CodingKey {
//        case id
//        case name
//        case phoneNo
//        case isPremium
//        case subscribers
//    }
//    
//    init(from decoder: any Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.id = try container.decode(String.self, forKey: .id)
//        self.name = try container.decode(String.self, forKey: .name)
//        self.phoneNo = try container.decode(String.self, forKey: .phoneNo)
//        self.isPremium = try container.decode(Bool.self, forKey: .isPremium)
//        self.subscribers = try container.decode(Int.self, forKey: .subscribers)
//    }
//    
//    func encode(to encoder: any Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(self.id, forKey: .id)
//        try container.encode(self.name, forKey: .name)
//        try container.encode(self.phoneNo, forKey: .phoneNo)
//        try container.encode(self.isPremium, forKey: .isPremium)
//        try container.encode(self.subscribers, forKey: .subscribers)
//    }
    
}

class CoadableViewModel: ObservableObject {
    @Published var user: User? = nil
    
    init(){
        getData()
    }
    
    func getData() {
        
        
        guard let data = getJSONData() else { return }
//        print("JSON Data\n\(data)")
//        let jsonString = String(data: data, encoding: .utf8)
//        print(jsonString)
//
//        if
//            let localData = try? JSONSerialization.jsonObject(with: data,options: []),
//            let dictionary = localData as? [String: Any],
//            let id = dictionary["id"] as? String,
//            let name = dictionary["name"] as? String,
//            let phoneNo = dictionary["phoneNo"] as? String,
//            let isPremium = dictionary["isPremium"] as? Bool,
//            let subscribers = dictionary["subscribers"] as? Int {
//
//            let newUser = User(
//                id: id,
//                name: name,
//                phoneNo: phoneNo,
//                isPremium: isPremium,
//                subscribers: subscribers
//            )
//            user = newUser
//            }
        /// we have already decodable model so we will not do it manually ^^^^
//        do {
//            self.user = try JSONDecoder().decode(User.self, from: data)
//        } catch let error{
//            print("Error decoding: \(error)")
//        }
        self.user = try? JSONDecoder().decode(User.self, from: data)

    }
    
    func getJSONData() -> Data? {
        let user = User(id: "544356", name: "Ali Ahmed", phoneNo: "0988578684", isPremium: false, subscribers: 98)
        let jsonData = try? JSONEncoder().encode(user)
//        let dictionary : [String:Any] = [
//            "id" : "544356",
//            "name" : "ali ahmen",
//            "phoneNo" : "0988578684",
//            "isPremium" : false,
//            "subscribers" : 98
//        ]
//        
//        let jsonData = try? JSONSerialization.data(withJSONObject: dictionary)
        return jsonData
    }
}

struct coadableProtocol: View {
    @StateObject var vm = CoadableViewModel()
    var body: some View {
        VStack(alignment: .leading) {
            if let user = vm.user {
                Text(user.id)
                Text(user.name)
                Text("\(user.subscribers)")

            }else {
                ProgressView()
            }
        }
    }
}

#Preview {
    coadableProtocol()
}
