struct FeedbackForm: Codable {
    
    let rating: Int
    let comment: String
    
    var isValid: Bool {
        return 1...5 ~= rating
    }
}
