////
////  ContentView.swift
////  MyCRM
////
////  Created by Alice Phuong Le on 11/1/24.
////
//
//import SwiftUI
//import CoreData
//
//struct ContentView: View {
//    @StateObject private var chatGPTManager = ChatGPTManager()
//    @State private var transcript = "I want to speak again 2 days later about the pricing strategy."
//
//    // You would typically get the NSManagedObjectContext from the environment in a real app.
//    // For testing purposes, we're just creating a new one.
//    let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
//
//    var body: some View {
//        VStack {
//            TextField("Transcript", text: $transcript)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .padding()
//
//            Button("Generate Task Summary") {
//                chatGPTManager.generateTaskSummary(from: transcript, in: context)
//            }
//            .disabled(chatGPTManager.isGenerating)
//
//            if let message = chatGPTManager.generatedMessage {
//                Text(message)
//                    .foregroundColor(.green)
//            }
//
//            if let errorMessage = chatGPTManager.errorMessage {
//                Text("Error: \(errorMessage)")
//                    .foregroundColor(.red)
//            }
//        }
//        .alert(isPresented: $chatGPTManager.showErrorAlert) {
//            Alert(title: Text("Error"), message: Text(chatGPTManager.errorMessage ?? "Unknown error"), dismissButton: .default(Text("OK")))
//        }
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
