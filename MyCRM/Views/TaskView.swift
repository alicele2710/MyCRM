////
////  TaskView.swift
////  MyCRM
////
////  Created by Alice Phuong Le on 11/1/24.
////
//
//import SwiftUI
//
//struct TaskView: View {
//    let transcriptDate: Date
//    let followUpDate: Date
//    let content: String
//
//    var body: some View {
//        VStack {
//            Text("Transcript from: \(transcriptDate, formatter: itemFormatter)")
//            Text("Follow-up on: \(followUpDate, formatter: itemFormatter)")
//            Text("Content: \(content)")
//        }
//    }
//}
//
//private let itemFormatter: DateFormatter = {
//    let formatter = DateFormatter()
//    formatter.dateStyle = .long
//    formatter.timeStyle = .none
//    return formatter
//}()
//#Preview {
//    TaskView(transcriptDate: Date(), followUpDate: Date(), content: "None")
//}
