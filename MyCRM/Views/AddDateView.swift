import SwiftUI
import CoreData
//struct AddDateView: View {
//    @Environment(\.managedObjectContext) var viewContext
//    var contact: Contact?
//    @Binding var isPresented: Bool
//    @State private var newDate: Date = Date()
//    @State private var newDateName: String = ""
//
//    var body: some View {
//        NavigationView {
//            Form {
//                DatePicker("Date", selection: $newDate, displayedComponents: .date)
//                TextField("Date Type (e.g., Birthday, Anniversary)", text: $newDateName)
//                Button("Add") {
//                    let importantDate = ImportantDate(context: viewContext)
//                    importantDate.date = newDate
//                    importantDate.name = newDateName
//                    contact?.addToImportantDates(importantDate)
//                    
//                    do {
//                        try viewContext.save()
//                    } catch {
//                        print("Error saving context: \(error)")
//                    }
//
//                    isPresented = false
//                }
//                .navigationBarTitle("Add Important Date", displayMode: .inline)
//                .navigationBarItems(trailing: Button("Cancel") { isPresented = false })
//            }
//        }
//    }
//}
import SwiftUI
import CoreData

struct AddDateView: View {
    @Environment(\.managedObjectContext) var viewContext
    // This closure will pass the new date info back to the parent view.
    var onAddDate: ((NewImportantDateInfo) -> Void)?
    @Binding var isPresented: Bool
    @State private var newDate: Date = Date()
    @State private var newDateName: String = ""
    @State private var showErrorAlert: Bool = false
    @State private var errorMessage: String = ""

    var body: some View {
        NavigationView {
            Form {
                DatePicker("Date", selection: $newDate, displayedComponents: .date)
                TextField("Date Type (e.g., Birthday, Anniversary)", text: $newDateName)
                Button("Add") {
                    addImportantDate()
                }
                .navigationBarTitle("Add Important Date", displayMode: .inline)
                .navigationBarItems(trailing: Button("Cancel") { isPresented = false })
            }
        }
        .alert(isPresented: $showErrorAlert) {
            Alert(
                title: Text("Error"),
                message: Text(errorMessage),
                dismissButton: .default(Text("OK"))
            )
        }
    }

    private func addImportantDate() {
        // Check if the date name is not empty
        guard !newDateName.isEmpty else {
            errorMessage = "Please enter a name for the date."
            showErrorAlert = true
            return
        }
        
    
        let newImportantDateInfo = NewImportantDateInfo(name: newDateName, date: newDate)
        onAddDate?(newImportantDateInfo)
        isPresented = false
    }
}


struct NewImportantDateInfo: Identifiable, Hashable {
    let id = UUID() // Adding identifiable conformance
    var name: String
    var date: Date
}

// MARK: - Previews
struct AddDateView_Previews: PreviewProvider {
    static var previews: some View {
        AddDateView(onAddDate: { newDateInfo in
            // Here you can handle the new date info, e.g., print it or add it to an array
            print(newDateInfo)
        }, isPresented: .constant(true))
    }
}
