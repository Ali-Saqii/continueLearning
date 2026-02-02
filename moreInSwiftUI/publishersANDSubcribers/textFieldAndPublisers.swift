//
//  textFieldAndPublisers.swift
//  moreInSwiftUI
//
//  Created by Mac mini on 03/02/2026.
//

import SwiftUI
internal import Combine

class textFieldPublisherViewModel: ObservableObject {
    @Published var count: Int = 0
    var cancelllables = Set<AnyCancellable>()
    
    @Published var textFieldText = ""
    @Published var textFieldValid = false
    @Published var showButton = false
    
    init() {
        addTextFieldsubscriber()
        setUPTimer()
        addButtonSubcriber()
    }
    func addTextFieldsubscriber() {
        $textFieldText
            .debounce(for: 1.0, scheduler: DispatchQueue.main)
            .map { (text) -> Bool in
                if text.count > 3 {
                    return true
                }
                return false
            }
            .sink { [weak self] (isValid) in
                self?.textFieldValid = isValid
                
            }
            .store(in: &cancelllables)
    }
    func setUPTimer() {
        Timer
            .publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _  in
                guard let self = self else{ return }
                self.count += 1
            }
            .store(in: &cancelllables)
    }
    
    func addButtonSubcriber() {
        $textFieldValid
            .combineLatest($count)
            .sink { [weak self] (isValid, count) in
                guard let self = self else { return }
                if isValid && count >= 10 {
                    self.showButton =  true
                } else {
                    self.showButton = false
                }
            }.store(in: &cancelllables)
    }
}

struct textFieldAndPublisers: View {
    @StateObject var vm = textFieldPublisherViewModel()
    var body: some View {
        VStack {
            Text("\(vm.count)")
                .font(.largeTitle)
                        
            TextField("Type something here...", text: $vm.textFieldText)
                .padding(.leading)
                .frame(height: 55)
                .font(.headline)
                .background(Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)))
                .cornerRadius(10)
                .overlay(
                    ZStack {
                        Image(systemName: "xmark")
                            .foregroundColor(.red)
                            .opacity(
                                vm.textFieldText.count < 1 ? 0.0 :
                                vm.textFieldValid ? 0.0 : 1.0)
                        
                        Image(systemName: "checkmark")
                            .foregroundColor(.green)
                            .opacity(vm.textFieldValid ? 1.0 : 0.0)
                    }
                    .font(.title)
                    .padding(.trailing)
                    
                    , alignment: .trailing
                )
            
            Button(action: {
                vm.count = 0
                vm.textFieldText = ""
                
            }, label: {
                Text("Submit".uppercased())
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .opacity(vm.showButton ? 1.0 : 0.5)
            })
            .disabled(!vm.showButton)
        }
        .padding()
    }
}

#Preview {
    textFieldAndPublisers()
}
