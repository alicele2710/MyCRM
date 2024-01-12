//
//  Contact+CoreDataProperties.swift
//  MyCRM
//
//  Created by Alice Phuong Le on 12/1/24.
//
//

import Foundation
import CoreData


extension Contact {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Contact> {
        return NSFetchRequest<Contact>(entityName: "Contact")
    }

    @NSManaged public var createdDate: Date?
    @NSManaged public var freqNumber: Int16
    @NSManaged public var freqPeriod: String?
    @NSManaged public var lastUpdated: Date?
    @NSManaged public var name: String?
    @NSManaged public var notes: String?
    @NSManaged public var tag: String?
    @NSManaged public var history: NSSet?
    @NSManaged public var importantDates: NSSet?
    @NSManaged public var tasks: NSSet?

}

// MARK: Generated accessors for history
extension Contact {

    @objc(addHistoryObject:)
    @NSManaged public func addToHistory(_ value: History)

    @objc(removeHistoryObject:)
    @NSManaged public func removeFromHistory(_ value: History)

    @objc(addHistory:)
    @NSManaged public func addToHistory(_ values: NSSet)

    @objc(removeHistory:)
    @NSManaged public func removeFromHistory(_ values: NSSet)

}

// MARK: Generated accessors for importantDates
extension Contact {

    @objc(addImportantDatesObject:)
    @NSManaged public func addToImportantDates(_ value: ImportantDate)

    @objc(removeImportantDatesObject:)
    @NSManaged public func removeFromImportantDates(_ value: ImportantDate)

    @objc(addImportantDates:)
    @NSManaged public func addToImportantDates(_ values: NSSet)

    @objc(removeImportantDates:)
    @NSManaged public func removeFromImportantDates(_ values: NSSet)

}

// MARK: Generated accessors for tasks
extension Contact {

    @objc(addTasksObject:)
    @NSManaged public func addToTasks(_ value: TaskSummary)

    @objc(removeTasksObject:)
    @NSManaged public func removeFromTasks(_ value: TaskSummary)

    @objc(addTasks:)
    @NSManaged public func addToTasks(_ values: NSSet)

    @objc(removeTasks:)
    @NSManaged public func removeFromTasks(_ values: NSSet)

}

extension Contact : Identifiable {

}
