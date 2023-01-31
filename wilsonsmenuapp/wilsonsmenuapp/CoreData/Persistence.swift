//
//  Persistence.swift
//  wilsonsmenuapp
//
//  Created by Wilson Chen on 11/3/22.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    
    let container: NSPersistentContainer

    init() {
        container = NSPersistentContainer(name: "wilsonsmenuapp")
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
}
