//
//  RecordingTimerView.swift
//  MyCRM
//
//  Created by Alice Phuong Le on 11/1/24.
//

import SwiftUI


struct RecordingTimerView: View {
    let isRecording: Bool

    var body: some View {
        Circle()
            .strokeBorder(lineWidth: 24)
            .overlay {
                VStack {
                    Text("Recording")
                        .font(.title)
                    Image(systemName: isRecording ? "mic" : "mic.slash")
                        .font(.title)
                        .padding(.top)
                        .accessibilityLabel(isRecording ? "with transcription" : "without transcription")
                }
                .accessibilityElement(children: .combine)

            }
            .padding(.horizontal)
    }
}

struct MeetingTimerView_Previews: PreviewProvider {
    static var previews: some View {
        RecordingTimerView(isRecording: true)
    }
}
