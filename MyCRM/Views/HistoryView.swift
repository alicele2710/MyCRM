//
//  HistoryView.swift
//  MyCRM
//
//  Created by Alice Phuong Le on 11/1/24.

import SwiftUI

struct TaskSummaryView: View {
    @Binding var isPresented: Bool
    let followUpDate: Date
    let content: String
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()


    var body: some View {
        VStack {
            Text("Task Summary")
                .font(.title)
            Text("Follow-up Date: \(dateFormatter.string(from: followUpDate))")
                                .padding(.bottom)
            Text(content)
            Button("Dismiss") {
                isPresented = false
            }
        }
    }
}
