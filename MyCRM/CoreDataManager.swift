//
//  CoreDataManager.swift
//  MyCRM
//
//  Created by Alice Phuong Le on 10/1/24.
//

import Foundation
import CoreData


class CoreDataManager {
    static let shared = CoreDataManager()
    private let persistentContainer: NSPersistentContainer

    init() {
        persistentContainer = NSPersistentContainer(name: "MyCRM") // Replace 'MyCRM' with your actual model name
        persistentContainer.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                // Proper error handling instead of fatalError in production
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }

    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    
    func addDateToContact(_ contact: Contact?, date: Date, name: String, context: NSManagedObjectContext) {
        let importantDate = ImportantDate(context: context)
        importantDate.date = date
        importantDate.name = name
        contact?.addToImportantDates(importantDate)
        
//        saveContext(context)
    }
    
    func saveContext(_ context: NSManagedObjectContext) throws {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                throw error
            }
        }
    }
    

    func deleteDateFromContact(_ date: ImportantDate, from contact: Contact, context: NSManagedObjectContext) throws {
        context.delete(date)
        try saveContext(context)
    }
    
    
    func addNewContact(name: String, notes: String, tag: String, freqNumber: Int16, freqPeriod: String, importantDatesInfo: [NewImportantDateInfo], context: NSManagedObjectContext) throws {
        let newContact = Contact(context: context)
        newContact.name = name
        newContact.notes = notes
        newContact.tag = tag
        newContact.freqNumber = freqNumber
        newContact.freqPeriod = freqPeriod

        for dateInfo in importantDatesInfo {
            let importantDate = ImportantDate(context: context)
            importantDate.date = dateInfo.date
            importantDate.name = dateInfo.name
            newContact.addToImportantDates(importantDate)
        }

        try saveContext(context)
    }
    
    func createTaskSummary(followUpDate: Date, content: String, context: NSManagedObjectContext? = nil) throws {
        let context = context ?? viewContext
        context.performAndWait {
            let taskSummary = TaskSummary(context: context)
            taskSummary.followUpDate = followUpDate
            taskSummary.content = content
            taskSummary.createdDate = Date()
            taskSummary.id = UUID()

            do {
                try saveContext(context)
            } catch {
                print("Core Data save error: \(error)")
//                throw error
            }
        }
    }
}
