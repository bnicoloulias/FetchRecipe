//
//  StorageProvider.swift
//  FetchRecipe
//
//  Created by Bobby Nicoloulias on 2/7/25.
//

import CoreData

class StorageProvider {
    let container: NSPersistentContainer

    init() {
        container = NSPersistentContainer(name: "ImageCacheModel")
        
        container.loadPersistentStores { _, error in
            if let error {
                fatalError("Failed to load persistent stores. Error: \(error)")
            }
        }
    }
}
