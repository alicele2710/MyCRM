//
//  DetailView.swift
//  MyCRM
//
//  Created by Alice Phuong Le on 10/1/24.
//



import SwiftUI

struct DetailView: View {
    @State var contact: Contact
    @State private var isPresentingEditView = false
    @Environment(\.managedObjectContext) var managedObjectContext
    @State private var checkedSummaries: [UUID: Bool] = [:]
    
    var body: some View {
        List {
            contactInfoSection
            importantDatesSection
            recordingNotesSection
//            tasksSection
        }
        .navigationTitle(contact.name ?? "Unknown Contact")
        .toolbar {
            Button("Edit") {
                isPresentingEditView = true
            }
        }
        .sheet(isPresented: $isPresentingEditView) {
            DetailEditView(contact: contact)
        }
    }
    
    private var contactInfoSection: some View {
        Section(header: Text("Contact Info")) {
            if let notes = contact.notes, !notes.isEmpty {
                Text(notes).padding(4).cornerRadius(4)
            }
            tagView
            frequencyView
        }
    }
    
    private var tagView: some View {
        HStack {
            Label("Tag", systemImage: "tag")
            Spacer()
            Text(contact.tag ?? "None")
                .padding(4)
                .cornerRadius(4)
        }
    }
    
    private var frequencyView: some View {
        HStack {
            Label("Frequency", systemImage: "calendar")
            Spacer()
            Text("every \(contact.freqNumber) \(contact.freqPeriod ?? "month")")
                .padding(4)
                .cornerRadius(4)
        }
    }
    
    private var importantDatesSection: some View {
        Section(header: Text("Important Dates")) {
            if let importantDatesSet = contact.importantDates as? Set<ImportantDate>, !importantDatesSet.isEmpty {
                ForEach(Array(importantDatesSet), id: \.self) { importantDate in
                    importantDateView(importantDate)
                }
            } else {
                Text("No important dates").italic()
            }
        }
    }
    
    private func importantDateView(_ importantDate: ImportantDate) -> some View {
        HStack {
            Text(importantDate.name ?? "Event")
            Spacer()
            Text(importantDate.date ?? Date(), style: .date)
        }
    }
    
    private var recordingNotesSection: some View {
        Section(header: Text("Recording Notes")){
            NavigationLink(destination: RecordingView(contact: $contact)) {
                Label("Note Recording", systemImage: "pencil.circle")
                    .font(.headline)
                    .foregroundColor(.accentColor)
            }
        }
    }
    
//    private var tasksSection: some View {
//        Section(header: Text("Tasks")) {
//            if let taskSet = contact.tasks as? Set<TaskSummary>, !taskSet.isEmpty {
//                ForEach(Array(taskSet), id: \.self) { task in
//
//                    if let taskId = task.id {
//                        TaskSummaryRow(taskSummary: task, isChecked: Binding(
//                            get: { self.checkedSummaries[taskId] ?? false },
//                            set: { self.checkedSummaries[taskId] = $0 }
//                        ))
//                    }
//                }
//            } else {
//                Text("No task summaries").italic()
//            }
//            
//        }
//    }
}


struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.preview.container.viewContext
        let newContact = Contact(context: context)

        return DetailView(contact: newContact).environment(\.managedObjectContext, context)
    }
}
