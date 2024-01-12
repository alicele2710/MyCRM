//
//  noteTimer.swift
//  MyCRM
//
//  Created by Alice Phuong Le on 11/1/24.
//

import Foundation


/// Keeps time for a daily scrum meeting. Tracks the total meeting time.
@MainActor
final class noteTimer: ObservableObject {
    
    /// The number of seconds since the beginning of the meeting.
    @Published var secondsElapsed = 0
    /// The number of seconds remaining in the meeting.
    @Published var secondsRemaining = 0

    /// The fixed meeting length in minutes.
    private let lengthInMinutes: Int = 1 // Set fixed length as a constant
    private var lengthInSeconds: Int { lengthInMinutes * 60 }
    
    /// A closure that is executed when the timer completes.
    var timerEndedAction: (() -> Void)?

    private weak var timer: Timer?
    private var timerStopped = false
    private var frequency: TimeInterval { 1.0 / 60.0 }
    private var startDate: Date?
    
    init() {
        secondsRemaining = lengthInSeconds
    }
    
    /// Start the timer.
    func startScrum() {
        timerStopped = false
        timer = Timer.scheduledTimer(withTimeInterval: frequency, repeats: true) { [weak self] _ in
            // Capture a strong reference to `self` within the task if it's not nil
            guard let strongSelf = self else { return }
            
            // Execute `update` on the main actor (main thread)
            Task { @MainActor in
                strongSelf.update()
            }
        }
        timer?.tolerance = 0.1
        startDate = Date()
    }
    
    /// Called by the timer to update the elapsed and remaining seconds.
    private func update() {
        // Ensure we're not stopped and we have a start date
        guard let startDate = startDate, !timerStopped else { return }
        
        let now = Date()
        secondsElapsed = Int(now.timeIntervalSince(startDate))
        secondsRemaining = max(lengthInSeconds - secondsElapsed, 0)
        
        if secondsRemaining == 0 {
            timer?.invalidate()
            timerEndedAction?()
        }
    }
    
    /// Stop the timer.
    func stopScrum() {
        timer?.invalidate() // This stops the timer from firing.
        timerStopped = true // Update the state to indicate that the timer is stopped.
        // Any additional cleanup or state updates can go here.
    }

    /// Resets the timer to the initial state.
    func reset() {
        secondsElapsed = 0
        secondsRemaining = lengthInSeconds
        startDate = nil
    }
}
