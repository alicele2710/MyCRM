import SwiftUI
import CoreData
import ChatGPT


struct TaskSummaryDetails {
    var followUpDate: Date
    var content: String
}


class ChatGPTManager: ObservableObject {
    static let shared = ChatGPTManager()
    @Published var isGenerating = false
    @Published var generatedMessage: String?
    @Published var errorMessage: String?
    @Published var showErrorAlert = false
    

//    private let chatGPT = ChatGPT(apiKey: "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", defaultModel: .gpt3)
//    

    func generateTaskSummary(from transcript: String, in context: NSManagedObjectContext) async throws -> TaskSummaryDetails {
        isGenerating = true
        defer { isGenerating = false } // This will ensure isGenerating is set to false when the function exits.
        errorMessage = nil

        do {
            let taskDetails = try await askChatGPT(transcript: transcript)
            // No need to create a TaskSummary in Core Data here, just return the result
            try CoreDataManager.shared.createTaskSummary(followUpDate: taskDetails.followUpDate, content: taskDetails.content, context: context)
            return taskDetails
        } catch {
            errorMessage = error.localizedDescription
            showErrorAlert = true
            throw error // Re-throw the error to be handled by the caller
        }
    }
    
    private func askChatGPT(transcript: String) async throws -> TaskSummaryDetails {
//        let fullRequest = ChatRequest.gpt3 { request in
//
//            request.messages.append(.init(role: .system, content: "You are a helpful assistant analyzing a meeting transcript."))
//            request.messages.append(.init(role: .user, content: "Given this transcript: '\(transcript)', when should I follow up with the contact and what should the follow-up content be? The response will be short and to the point, containing just the number of days from now (no extra words needed) and the content in bullet points. This is the format: [Number]; [content]"))
//            request.temperature = 0.3
//            request.numberOfAnswers = 1
//        }
//        let response = try await chatGPT.ask(request: fullRequest)
//        let parsedResponse = response.choices.first?.message.content ?? "No response received."
//        print(parsedResponse)
        let parsedResponse = "call again in 2 days about pricing"

        let components = parsedResponse.components(separatedBy: "; ")
        guard components.count == 2,
              let daysString = components.first?.trimmingCharacters(in: .whitespaces),
              let days = Int(daysString) else {
            throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid response format"])
        }


        let followUpDate = Calendar.current.date(byAdding: .day, value: days, to: Date()) ?? Date()
        let content = components.last?.trimmingCharacters(in: .whitespaces) ?? ""


        return TaskSummaryDetails(followUpDate: followUpDate, content: content)
    }
}
