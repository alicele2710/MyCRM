import SwiftUI
import CoreData

struct DetailEditView: View {
    @ObservedObject var contact: Contact
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode


    @State private var newDateName: String = ""
    @State private var newDate: Date = Date()

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }

    private func addNewDate() {
        withAnimation {
            let newImportantDate = ImportantDate(context: viewContext)
            newImportantDate.name = newDateName
            newImportantDate.date = newDate
            contact.addToImportantDates(newImportantDate)

            newDateName = ""
            newDate = Date()
        }
    }

    private func saveContact() {
        if !newDateName.isEmpty {
            addNewDate() // Add the new date before saving
        }

        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }

        // Dismiss the view after saving
        presentationMode.wrappedValue.dismiss()
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Contact Info")) {
                    TextField("Name/Nickname", text: $contact.name.bound)
                    TextField("Personal Notes", text: $contact.notes.bound)
                    // Other fields for contact info...
                }

                Section(header: Text("Important Dates")) {
                    ForEach(contact.importantDatesArray, id: \.self) { importantDate in
                        HStack {
                            TextField("Date Name", text: Binding(
                                get: { importantDate.name ?? "" },
                                set: { importantDate.name = $0 }
                            ))
                            DatePicker(
                                "",
                                selection: Binding(
                                    get: { importantDate.date ?? Date() },
                                    set: { importantDate.date = $0 }
                                ),
                                displayedComponents: [.date]
                            )
                        }
                    }
                    .onDelete(perform: deleteDate)

                    HStack {
                        TextField("New Date Name", text: $newDateName)
                        DatePicker(
                            "",
                            selection: $newDate,
                            displayedComponents: [.date]
                        )
                        Button(action: {
                            addNewDate()
                        }) {
                            Image(systemName: "plus.circle.fill")
                        }
                    }
                }
            }
            .navigationBarTitle("Edit Contact")
            .navigationBarItems(trailing: Button("Save") {
                saveContact()
            })
        }
    }

    private func deleteDate(at offsets: IndexSet) {
        offsets.forEach { index in
            let dateToDelete = contact.importantDatesArray[index]
            viewContext.delete(dateToDelete)
        }
    }
}

extension Contact {
    public var importantDatesArray: [ImportantDate] {
        (importantDates as? Set<ImportantDate> ?? []).sorted {
            $0.date ?? Date() < $1.date ?? Date()
        }
    }
}

extension Optional where Wrapped == String {
    var bound: String {
        get { self ?? "" }
        set { self = newValue.isEmpty ? nil : newValue }
    }
}



struct DetailEditView_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.preview.container.viewContext
        let newContact = Contact(context: context)
        return DetailEditView(contact: newContact).environment(\.managedObjectContext, context)
    }
}

// Assuming PersistenceController is your CoreData stack setup class
