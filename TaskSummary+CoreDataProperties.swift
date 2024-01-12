//
//  TaskSummary+CoreDataProperties.swift
//  MyCRM
//
//  Created by Alice Phuong Le on 12/1/24.
//
//

import Foundation
import CoreData


extension TaskSummary {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskSummary> {
        return NSFetchRequest<TaskSummary>(entityName: "TaskSummary")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var createdDate: Date?
    @NSManaged public var followUpDate: Date?
    @NSManaged public var content: String?
    @NSManaged public var contact: Contact?

}

extension TaskSummary : Identifiable {

}
