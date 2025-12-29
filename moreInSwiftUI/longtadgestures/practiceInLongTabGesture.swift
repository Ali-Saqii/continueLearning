//
//  Modelbootcamp.swift
//  SwiftUiBootcamp
//
//  Created by Mac mini on 10/12/2025.
//

import SwiftUI

struct UserModel: Identifiable {
//    var id = "dfgg"
    let id = UUID().uuidString
    let displayName: String
    let userName: String
    let followers: Int
    let ispremium: Bool = false
    let profileImageURL: String



    func userPremium (followers: Int) ->Bool{
    
        if followers >= 1500 {
          return true
        }
        return false
    }

}

struct Modelbootcamp: View {
    @State var users: [UserModel] = [
        UserModel(displayName: "Ali Khan", userName: "@alikhan", followers: 1200, profileImageURL: "https://i.pravatar.cc/150?img=1"),
        UserModel(displayName: "Sara Ahmed", userName: "@saraahmed", followers: 980, profileImageURL: "https://i.pravatar.cc/150?img=2"),
        UserModel(displayName: "Omar Farooq", userName: "@omarfarooq", followers: 1500, profileImageURL: "https://i.pravatar.cc/150?img=3"),
        UserModel(displayName: "Ayesha Malik", userName: "@ayeshamalik", followers: 450, profileImageURL: "https://i.pravatar.cc/150?img=5"),
        UserModel(displayName: "Hassan Riaz", userName: "@hassanriaz", followers: 2300, profileImageURL: "https://i.pravatar.cc/150?img=4"),
        UserModel(displayName: "Zainab Tariq", userName: "@zainabtariq", followers: 670, profileImageURL: "https://i.pravatar.cc/150?img=10"),
        UserModel(displayName: "Bilal Saeed", userName: "@bilalsaeed", followers: 890, profileImageURL: "https://i.pravatar.cc/150?img=7"),
        UserModel(displayName: "Faizan Ahmed", userName: "@faizanahmed", followers: 540, profileImageURL: "https://i.pravatar.cc/150?img=8"),
        UserModel(displayName: "Usman Ali", userName: "@usmanali", followers: 1320, profileImageURL: "https://i.pravatar.cc/150?img=6"),
        UserModel(displayName: "emily james", userName: "@noorjaved", followers: 780, profileImageURL: "https://i.pravatar.cc/150?img=9"),
        UserModel(displayName: "Emily Johnson", userName: "@emilyjohnson", followers: 1850, profileImageURL: "https://i.pravatar.cc/150?img=11"),
        UserModel(displayName: "Michael Smith", userName: "@michaelsmith", followers: 2400, profileImageURL: "https://i.pravatar.cc/150?img=12"),
        UserModel(displayName: "Sophia Brown", userName: "@sophiabrown", followers: 920, profileImageURL: "https://i.pravatar.cc/150?img=13"),
        UserModel(displayName: "Daniel Wilson", userName: "@danielwilson", followers: 3100, profileImageURL: "https://i.pravatar.cc/150?img=14"),
        UserModel(displayName: "Olivia Martinez", userName: "@oliviamartinez", followers: 1650, profileImageURL: "https://i.pravatar.cc/150?img=15"),
        UserModel(displayName: "James Anderson", userName: "@jamesanderson", followers: 2750, profileImageURL: "https://i.pravatar.cc/150?img=16"),
        UserModel(displayName: "Emma Thompson", userName: "@emmathompson", followers: 1340, profileImageURL: "https://i.pravatar.cc/150?img=17"),
        UserModel(displayName: "William Taylor", userName: "@williamtaylor", followers: 890, profileImageURL: "https://i.pravatar.cc/150?img=18"),
        UserModel(displayName: "Charlotte Moore", userName: "@charlottemoore", followers: 2100, profileImageURL: "https://i.pravatar.cc/150?img=19"),
        UserModel(displayName: "Lucas Miller", userName: "@lucasmiller", followers: 1580, profileImageURL: "https://i.pravatar.cc/150?img=20")

    ]
    @State private var isFollowed: Bool = false
    @State private var isFavourite: Bool = false
    var body: some View {
        NavigationStack {
            List{
                ForEach(users) { user in
                    NavigationLink {
                        followersProfileView(name: user.displayName, userName: user.userName, followers: user.followers, imageURL: user.profileImageURL, isPremium: user.userPremium(followers: user.followers))
                    } label: {
                        HStack {
                            AsyncImage(url: URL(string: user.profileImageURL)) { phase in
                                if let image = phase.image {
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 40, height: 40)
                                        .clipShape(Circle())
                                    
                                } else if phase.error != nil {
                                    Image(systemName: "person.crop.circle.fill")
                                        .resizable()
                                        .frame(width: 40, height: 40)
                                        .foregroundColor(.gray)
                                    
                                } else {
                                    ProgressView()
                                        .frame(width: 40, height: 40)
                                }
                            }
                            
                            VStack(alignment: .leading) {
                                Text(user.displayName)
                                    .font(.headline)
                                Text(user.userName)
                                    .font(.caption)
                            }
                            Spacer()
                            
                            if user.userPremium(followers: user.followers) {
                                Image(systemName: "checkmark.seal.fill")
                                    .foregroundStyle(.blue)
                            }
                            VStack(alignment: .leading) {
                                Text("\(user.followers)")
                                Text("followers")
                                    .font(.caption)
                            }
                        }.swipeActions {
                            Button(role: .destructive) {
                                // delete logic
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }

                            Button {
                                isFavourite.toggle()
                            } label: {
                                Image(systemName: isFavourite ? "heart.fill" : "heart")
                                    .font(.title2)
                                    .foregroundColor(isFavourite ? .red : .white)
                            }
                            .tint(.mint) // swipe background color
                        }
                        .swipeActions(edge: .leading) {
                            Button {
                                isFollowed.toggle()
                            } label: {
                                Text(isFollowed ? "un Follow":"follow Back".capitalized)
                                    .font(.headline)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.white)
                            }.tint(.green)
                        }
                    }
                    
                    
                    
                } .listStyle(PlainListStyle())
                
            }.badge(8)
                .navigationTitle("Followers")
            
        }
    }
}

struct followersProfileView: View {
    let name: String
    let userName: String
    let followers: Int
    let imageURL: String
    let isPremium :Bool
    
    let imageURLs: [String] = [
        "https://images.unsplash.com/photo-1500530855697-b586d89ba3ee",
        "https://images.unsplash.com/photo-1501785888041-af3ef285b470",
        "https://images.unsplash.com/photo-1526336024174-e58f5cdd8e13",
        "https://images.unsplash.com/photo-1491553895911-0055eca6402d",
        "https://images.unsplash.com/photo-1519681393784-d120267933ba",
        "https://images.unsplash.com/photo-1506744038136-46273834b3fb",
        "https://images.unsplash.com/photo-1470770841072-f978cf4d019e",
        "https://images.unsplash.com/photo-1507525428034-b723cf961d3e",
        "https://images.unsplash.com/photo-1518837695005-2083093ee35b",
        "https://images.unsplash.com/photo-1503264116251-35a269479413",
        "https://images.unsplash.com/photo-1492724441997-5dc865305da7",
        "https://images.unsplash.com/photo-1504198453319-5ce911bafcde",
        "https://images.unsplash.com/photo-1500534314209-a25ddb2bd429",
        "https://images.unsplash.com/photo-1482192596544-9eb780fc7f66",
        "https://images.unsplash.com/photo-1472214103451-9374bd1c798e"
    ]
    let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: 2), count: 3)
    @State private var isSelected = false
    var body: some View {
        ZStack {
            VStack {
                VStack {
                    HStack {
                        AsyncImage(url: URL(string:imageURL)) { phase in
                            if let image = phase.image {
                                image
                                    .resizable()
                                    .scaledToFill()
                            } else if phase.error != nil {
                                Image(systemName: "person.crop.circle.fill")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 100, height: 100)
                                    .foregroundColor(.gray)
                            } else {
                                ProgressView()
                            }
                        }
                        .frame(width: 120, height: 120)
                        .clipShape(Circle())
                        VStack(alignment:.leading ,spacing: 0) {
                            HStack {
                                Text(name.capitalized)
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                
                                if isPremium {
                                    Image(systemName: "checkmark.seal.fill")
                                        .foregroundStyle(.blue)
                                }
                                
                            }
                            Text(userName.capitalized)
                                .font(.callout)
                            
                        }
                        Spacer()
                        VStack {
                            Text("\(followers)")
                                .font(.title2)
                                .fontWeight(.semibold);   Text("Followers".capitalized)
                                .font(.callout)
                            
                        }
                    }.frame(maxWidth: .infinity,alignment: .leading)
                    
                    
                    
                }.padding(.horizontal)
                
                Divider()
                ScrollView(showsIndicators: false) {
                    LazyVGrid(columns: columns, spacing: 2) {
                        ForEach(imageURLs, id:\.self) { image in
                            AsyncImage(url: URL(string:image)) { phase in
                                if let image = phase.image {
                                    image
                                        .resizable()
                                } else if phase.error != nil {
                                    Image(systemName: "photo")
                                        .resizable()
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 150)
                                        .clipped()
                                } else {
                                    ProgressView()
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: 150)
                            .onLongPressGesture(perform: {
                                isSelected.toggle()
                            })
                            .overlay(alignment: .topTrailing) {
                                if isSelected {
                                    Circle()
                                        .fill(.green)
                                        .frame(width: 15,height: 15)
                                }
                            }
                           
                            
                            
                        }
                    }
                 
                    
                }.padding(.horizontal,5)
                
            }
           
        }.navigationTitle("User Profile")
        
    }
}

#Preview {
    Modelbootcamp()

}
