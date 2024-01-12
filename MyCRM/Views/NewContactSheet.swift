
import SwiftUI
import CoreData

struct NewContactSheet: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Binding var isPresentingNewContactView: Bool
    @State private var newContactName: String = ""
    @State private var newContactNotes: String = ""
    @State private var selectedTag: String = "Professional"
    @State private var freqNumber: Int16 = 1
    @State private var freqPeriod: String = "Day"
    @State private var newDateName: String = ""
    @State private var newDate: Date = Date()
    @State private var importantDatesInfo: [NewImportantDateInfo] = []

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("CONTACT INFO")) {
                    TextField("Name/Nickname", text: $newContactName)
                    TextField("Personal Notes", text: $newContactNotes)
                    FrequencyPicker(freqNumber: $freqNumber, freqPeriod: $freqPeriod)
                }
                
                Section(header: Text("IMPORTANT DATES")) {
                    ForEach($importantDatesInfo.indices, id: \.self) { index in
                        HStack {
                            TextField("Date Name", text: $importantDatesInfo[index].name)
                            DatePicker(
                                "",
                                selection: $importantDatesInfo[index].date,
                                displayedComponents: [.date]
                            )
                            .datePickerStyle(CompactDatePickerStyle())
                        }
                    }
                    .onDelete(perform: deleteDate)
                }
                
                Button(action: {
                    // Add a new date with the current input values
                    importantDatesInfo.append(NewImportantDateInfo(name: newDateName, date: newDate))
                    // Reset the input values for the next entry
                    newDateName = ""
                    newDate = Date()
                }) {
                    Text("Add Date")
                }
            }
            .navigationBarTitle("New Contact", displayMode: .inline)
            .navigationBarItems(
                leading: Button("Dismiss") {
                    isPresentingNewContactView = false
                },
                trailing: Button("Save") {
                    _ = try? addNewContact()

                    isPresentingNewContactView = false
                }
            )
        }
    }
    
    private func deleteDate(at offsets: IndexSet) {
        importantDatesInfo.remove(atOffsets: offsets)
    }
    
    private func addNewContact() throws {
        let newContact = Contact(context: viewContext)
        newContact.name = newContactName
        newContact.notes = newContactNotes
        newContact.tag = selectedTag
        newContact.freqNumber = freqNumber
        newContact.freqPeriod = freqPeriod
        
        for dateInfo in importantDatesInfo {
            let importantDate = ImportantDate(context: viewContext)
            importantDate.date = dateInfo.date
            importantDate.name = dateInfo.name
            newContact.addToImportantDates(importantDate)
        }
        
        try CoreDataManager.shared.saveContext(viewContext)
    }
}


struct NewContactSheet_Previews: PreviewProvider {
    static var previews: some View {
        NewContactSheet(isPresentingNewContactView: .constant(true))
            // Provide the managed object context from the preview provider
    }
}

