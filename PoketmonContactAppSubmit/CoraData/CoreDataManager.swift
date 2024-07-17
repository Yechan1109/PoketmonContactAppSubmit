//
//  CoreDataManager.swift
//  PoketmonContactAppSubmit
//
//  Created by t2023-m0013 on 7/17/24.
//

import CoreData
import UIKit

class CoreDataManager {
    static let shared = CoreDataManager()
    let persistentContainer: NSPersistentContainer
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "ContactModel")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
    }
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
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
    }
    
    func saveContact(name: String, number: String, image: UIImage?) {
        let context = CoreDataManager.shared.context
        let contact = Contact(context: context)
        contact.name = name
        contact.number = number
        if let image = image, let imageData = image.pngData() {
            contact.image = imageData
        }
        saveContext()
    }
}

