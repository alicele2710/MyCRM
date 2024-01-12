//
//  FrequencyPicker.swift
//  MyCRM
//
//  Created by Alice Phuong Le on 10/1/24.
//

import SwiftUI

enum FrequencyPeriod: String, CaseIterable {
    case day = "Day"
    case week = "Week"
    case month = "Month"
    // Add more cases if needed
}
struct FrequencyPicker: View {
    @Binding var freqNumber: Int16
    @Binding var freqPeriod: String

    var body: some View {
        HStack {
            Text("Frequency")
                .font(.caption)
                .foregroundColor(.primary)
                .padding(4)
                .frame(width: 80, alignment: .leading)

            Picker("Number", selection: $freqNumber) {
                ForEach(1...30, id: \.self) {
                    Text("\($0)").tag(Int16($0))
                }
            }
            .pickerStyle(.wheel)
            .frame(width: 100, height: 100)
            .clipped()

            Picker("Period", selection: $freqPeriod) {
                ForEach(FrequencyPeriod.allCases, id: \.self) { period in
                    Text(period.rawValue).tag(period.rawValue)
                }
            }
            .pickerStyle(.wheel)
            .frame(width: 100, height: 100)
            .clipped()
        }
    }
}

struct FrequencyPicker_Previews: PreviewProvider {
    @State static var previewFreqNumber: Int16 = 1
    @State static var previewFreqPeriod: String = FrequencyPeriod.day.rawValue

    static var previews: some View {
        FrequencyPicker(freqNumber: $previewFreqNumber, freqPeriod: $previewFreqPeriod)
    }
}
