//
//  TaskSummaryRow.swift
//  MyCRM
//
//  Created by Alice Phuong Le on 12/1/24.
//

//import SwiftUI
//
//struct TaskSummaryRow: View {
//    let taskSummary: TaskSummary
//    @Binding var isChecked: Bool
//    
//    var body: some View {
//        HStack {
//            Image(systemName: isChecked ? "checkmark.square" : "square")
//                .onTapGesture {
//                    isChecked.toggle()
//                }
//            Text(taskSummary.followUpDate ?? Date(), style: .date) + Text(" - ") + Text(taskSummary.content ?? "")
//                .strikethrough(isChecked, color: .black)
//        }
//    }
//}
