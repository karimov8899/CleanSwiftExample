//
//  CoreDataManager.swift
//  CleanSwiftTest
//
//  Created by Davron on 26.05.2021.
//

import Foundation
import CoreData
import UIKit

//CoreDataManager protocol

protocol CoreDataManagerProtocol {
    func saveContext()
    func fetchData() -> [Places]
    func deleteItem(item: Places) -> Bool
}

//CoreDataManager

class CoreDataManager: CoreDataManagerProtocol {
    
    
    static let shared = CoreDataManager()
    
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CleanSwiftTest")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
     
    func saveContext () {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch { 
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
      
    func fetchData() -> [Places] {
        do {
            let context = persistentContainer.viewContext
            let items = try context.fetch(Places.fetchRequest()) as! [Places]
            return items
        } catch  {
            return []
        }
    }
    
    func deleteItem(item: Places) -> Bool {
        let context = persistentContainer.viewContext
        context.delete(item)
        do {
            try context.save()
            return true
        } catch  { 
            return false
        }
    }
    
    func createItems() {
        let items = CoreDataManager.shared.fetchData()
        let context = CoreDataManager.shared.persistentContainer.viewContext
        if items.count == 0 {
            for i in 0...4 {
                let newItem = Places(context: context)
                newItem.titile = "TestCity \(i)"
                newItem.detail = "TestDescrition \(i)"
                newItem.url = "https://images.unsplash.com/photo-1480714378408-67cf0d13bc1b?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=2250&q=80"
            }
            saveContext()
        }
    }
}
