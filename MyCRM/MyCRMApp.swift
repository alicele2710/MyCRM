//
//  MyCRMApp.swift
//  MyCRM
//
//  Created by Alice Phuong Le on 10/1/24.
//

import SwiftUI

@main
struct MyCRMApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContactsView(saveAction: {
                // Implement the save action here.
                // For example, save the context if there are changes.
                do {
                    if persistenceController.container.viewContext.hasChanges {
                        try persistenceController.container.viewContext.save()
                    }
                } catch {
                    // Handle any error, perhaps log it or present an alert to the user.
                    print("Error saving managed object context: \(error)")
                }
            })
            .environment(\.managedObjectContext, persistenceController.container.viewContext)

        }
        
    }
}
