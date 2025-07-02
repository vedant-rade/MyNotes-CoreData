//
//  PersistentStorage.swift
//  MyNotes
//
//  Created by apple on 24/06/25.
//

import Foundation
import CoreData

// MARK: Why use final?
// Prevent inheritance — ensures that no subclass changes the behavior.
// Performance benefit — compiler can optimize method dispatch (no need for dynamic dispatch via vtable).
// Intentional design — you’re signaling: “This class is complete; don’t extend it.”

final class PersistentStorage {
    
    private init() {}
    static let shared = PersistentStorage() // 🔐 Prevent external initialization
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MyNotes")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var context = persistentContainer.viewContext

    // MARK: - Core Data Saving support

    func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func fetchManagedObject<T: NSManagedObject>(managedObject: T.Type) -> [T]? {
        do {
            guard let result = try PersistentStorage.shared.context.fetch(managedObject.fetchRequest()) as? [T] else { return nil }
            
            return result
        } catch let error {
            print("Error in fetching ManagedObjects: \(error)")
        }
        
        return nil
    }
}
