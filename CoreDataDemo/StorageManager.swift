//
//  StorageManager.swift
//  CoreDataDemo
//
//  Created by Olga Yurchuk on 17.10.2022.
//

import Foundation
import CoreData

class StorageManager {
    static let shared = StorageManager()
    
    // MARK: - New Entity Task
    func newEntity(forEntityName: String, in context: NSManagedObjectContext) -> Any? {
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "Task", in: context) else {return ""}
        guard let task = NSManagedObject(entity: entityDescription, insertInto: context) as? Task else { return ""}
        return task
        
    }

    
    // MARK: - Core Data stack
    var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreDataDemo")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }}