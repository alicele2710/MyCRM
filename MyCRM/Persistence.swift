//
//  Persistence.swift
//  MyCRM
//
//  Created by Alice Phuong Le on 10/1/24.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    // Set up a preview for development and testing
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext

        // Create sample data for preview
        for _ in 0..<10 {
            let newContact = Contact(context: viewContext)
            newContact.name = "Sample Contact"
            newContact.createdDate = Date()
            newContact.freqNumber = 7
            newContact.freqPeriod = "days"
            newContact.notes = "Sample notes"
            // Add other attributes as needed
        }

        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "MyCRM")
        if inMemory {
            // Use an in-memory store for previews or testing
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
