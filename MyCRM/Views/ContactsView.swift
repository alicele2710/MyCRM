//
//  ContactsView.swift
//  MyCRM
//
//  Created by Alice Phuong Le on 10/1/24.
//

import SwiftUI
import CoreData

struct ContactsView: View {
    @Environment(\.managedObjectContext) private var managedObjectContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Contact.name, ascending: true)],
        animation: .default)
    private var contacts: FetchedResults<Contact>
    
    @State private var isPresentingNewContactView = false
    let saveAction: ()->Void

    var body: some View {
        NavigationStack {
            List {
                ForEach(contacts) { contact in
                    NavigationLink(destination: DetailView(contact: contact)) {
                        Text(contact.name ?? "Unknown")
                    }
                }
                .onDelete(perform: deleteContacts)
            }
            .navigationTitle("Contacts")
            .toolbar {
                Button(action: {
                    isPresentingNewContactView = true
                }) {
                    Label("Add Contact", systemImage: "plus")
                }
                .accessibilityLabel("New Contact")
            }
        }
        .sheet(isPresented: $isPresentingNewContactView) {
            NewContactSheet(isPresentingNewContactView: $isPresentingNewContactView)
                .environment(\.managedObjectContext, self.managedObjectContext)
        }
    }
    
    private func deleteContacts(offsets: IndexSet) {
        withAnimation {
            offsets.map { contacts[$0] }.forEach(managedObjectContext.delete)
            saveAction()
        }
    }
}

struct ContactsView_Previews: PreviewProvider {
    static var previews: some View {
        ContactsView(saveAction: {})
    }
}
