//
//  History+CoreDataProperties.swift
//  MyCRM
//
//  Created by Alice Phuong Le on 12/1/24.
//
//

import Foundation
import CoreData


extension History {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<History> {
        return NSFetchRequest<History>(entityName: "History")
    }

    @NSManaged public var date: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var transcript: String?
    @NSManaged public var contact: Contact?

}

extension History : Identifiable {

}
