class Persistence {
    
    private var feedback: [Feedback] = []
    
    func getAllFeedback() -> [Feedback] {
        return feedback.sorted { $0.date.compare($1.date) == .orderedDescending }
    }
    
    func add(_ feedback: Feedback) {
        self.feedback.append(feedback)
    }
}
