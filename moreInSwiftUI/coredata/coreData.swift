//
//  coreData.swift
//  moreInSwiftUI
//
//  Created by Mac mini on 16/01/2026.
//

import SwiftUI



struct coreData: View {
    
    @StateObject var vm: CoreDataViewModel = CoreDataViewModel()
    @State private var textFieldText = ""
    private var isDisabled: Bool {
        textFieldText
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .count < 3
    }
    var body: some View {
        
        NavigationStack {
            VStack {
                TextField("Type a message", text: $textFieldText)
                    .padding(12)
                    .background(Color(.systemGray6))
                    .cornerRadius(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.gray.opacity(0.3))
                    )
                    .padding(.horizontal)
                Button {
                    withAnimation {
                        vm.addBorrower(text: textFieldText)
                        textFieldText = ""
                    }
                    print("button pressed")
                } label: {
                    Text("submit".capitalized)
                        .font(.title3)
                        .foregroundColor(.white)
                        .padding(12)
                        .frame(maxWidth: .infinity)
                    
                }.background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(isDisabled ? .gray : .green)
                )
                .padding()
                .disabled(isDisabled)
                List {
                    ForEach(vm.savedBorrowers) { borrower in
                        
                        Text(borrower.name ??  "error" )
                            .onTapGesture {
                            vm.UpdatBorrower(entity: borrower)
                        }
                    }.onDelete(perform: vm.deleteBorrower)
                }.listStyle(PlainListStyle())
                
            }.navigationTitle("borrowers")
        }
    }
}
#Preview {
    coreData()
}
