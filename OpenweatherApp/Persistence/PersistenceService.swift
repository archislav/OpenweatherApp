//
//  PersistenceService.swift
//  OpenweatherApp
//
//  Created by Сергей Морозов on 21.02.18.
//  Copyright © 2018 Сергей Морозов. All rights reserved.
//

import Foundation
import CoreData

class PersistenceService {
    
    private init() {}
    
    static var viewContext: NSManagedObjectContext = {
        return persistentContainer.viewContext
    } ()
    
    static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "OpenweatherApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    static func saveViewContext () {
        let context = viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
