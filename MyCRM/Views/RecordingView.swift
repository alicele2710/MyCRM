//
//  RecordingView.swift
//  MyCRM
//
//  Created by Alice Phuong Le on 11/1/24.
//

import SwiftUI
import AVFoundation

struct SummaryContent {
    var followUpDate: Date
    var content: String
}
struct RecordingView: View {
    @Binding var contact: Contact
    @StateObject var noteTiming = noteTimer()
    @StateObject var speechRecognizer = SpeechRecognizer()
    @State private var isRecording = false
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject private var chatGPTManager = ChatGPTManager()
    @State private var showSummary = false
    @State private var summaryContent: SummaryContent?


    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16.0)
                .fill(.white)
            VStack {
                RecordingHeaderView(secondsElapsed: noteTiming.secondsElapsed, secondsRemaining: noteTiming.secondsRemaining)
                RecordingTimerView(isRecording: isRecording)
            }
        }
        .padding()

        .onAppear {
            startRecording()
        }
        .onDisappear {
            endRecording()
        }
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showSummary) {
            if let summaryContent = summaryContent {
                TaskSummaryView(isPresented: $showSummary,
                                followUpDate: summaryContent.followUpDate,
                                content: summaryContent.content)
            }
        }
    }
    
    private func startRecording() {
        noteTiming.reset()
        speechRecognizer.resetTranscript()
        speechRecognizer.startTranscribing()
        isRecording = true
        noteTiming.startScrum()
    }
//    private func endRecording() {
//        noteTiming.stopScrum()
//        speechRecognizer.stopTranscribing()
//        isRecording = false
//        let newHistory = History(context: viewContext)
//        newHistory.date = Date()
//        newHistory.transcript = speechRecognizer.transcript
//        newHistory.id = UUID()
//
//        contact.addToHistory(newHistory)
//
//        do {
//            try viewContext.save()
//        } catch {
//            print("Failed to save context: \(error)")
//        }
//
//        chatGPTManager.generateTaskSummary(from: newHistory.transcript ?? "", in: viewContext)
//        if let generatedMessage = chatGPTManager.generatedMessage {
//                   summaryContent = generatedMessage
//               }
//        showSummary = true
//
//    }
    private func endRecording() {
        // Stop timers and transcription
        noteTiming.stopScrum()
        speechRecognizer.stopTranscribing()
        isRecording = false

        // Create history object and add it to the contact
        let newHistory = History(context: viewContext)
        newHistory.date = Date()
        newHistory.transcript = speechRecognizer.transcript
        newHistory.id = UUID()
        contact.addToHistory(newHistory)

        // Save the context
        do {
            try viewContext.save()
        } catch {
            print("Failed to save context: \(error)")
        }

        // Generate task summary
        Task {
            do {
                // Assume generateTaskSummary is now an async function that returns the message
                let taskDetails = try await chatGPTManager.generateTaskSummary(from: newHistory.transcript ?? "", in: viewContext)
                // Now we show the summary after the message has been generated
                summaryContent = SummaryContent(followUpDate: taskDetails.followUpDate, content: taskDetails.content)
                showSummary = true
            } catch {
                print("Failed to generate task summary: \(error)")
            }
        }
    }


}

struct RecordingView_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.preview.container.viewContext
        let newContact = Contact(context: context)
        return RecordingView(contact: Binding.constant(newContact)).environment(\.managedObjectContext, context)
    }
}
