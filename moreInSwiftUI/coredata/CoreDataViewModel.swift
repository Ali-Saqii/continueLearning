//
//  CoreDataViewModel.swift
//  moreInSwiftUI
//
//  Created by Mac mini on 16/01/2026.
//

import Foundation
import CoreData
internal import Combine

class CoreDataViewModel: ObservableObject {
    
    @Published var savedBorrowers : [BorrowersEntity] = []
    
    
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "coreDataEntitiesFile")
        container.loadPersistentStores { Description, error in
            if let error = error {
                print("error while loading data: \(error)")
            }
            print("sucess fully load data")
        }
       fetchborrowers()
    }
    func fetchborrowers() {
        let request = NSFetchRequest<BorrowersEntity>(entityName: "BorrowersEntity")
        
        do {
          savedBorrowers =  try  container.viewContext.fetch(request)
        } catch let error {
            print("fetch error \(error)")
        }
    }
    func addBorrower(text : String) {

            let newborrower = BorrowersEntity(context: container.viewContext)
            newborrower.name = text
            saveData()
     
    }
    
    func deleteBorrower(indexSet: IndexSet) {
        guard let index = indexSet.first else {
            print("Erro while deleting borrower")
            return
        }
        let entitiy = savedBorrowers[index]
        container.viewContext.delete(entitiy)
        saveData()
       
    }
    func UpdatBorrower(entity : BorrowersEntity) {
        let currentName = entity.name ?? ""
        let newName = currentName + "111"
        entity.name = newName
        saveData()
    }
    func saveData() {
        do {
            try container.viewContext.save()
            fetchborrowers()
        }catch let error {
            print("error while saveing data. error is : \(error)")
        }
    }
}

