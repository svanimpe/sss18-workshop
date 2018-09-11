import Foundation

struct FeedbackPageViewModel: Codable {
    
    let showConfirmation: Bool
    
    struct FeedbackViewModel: Codable {
        
        let date: String
        let rating: Int
        let comment: String
        
        init(_ feedback: Feedback) {
            let formatter = DateFormatter()
            formatter.dateStyle = .short
            formatter.timeStyle = .none
            self.date = formatter.string(from: feedback.date)
            self.rating = feedback.rating
            self.comment = feedback.comment
        }
    }
    let feedback: [FeedbackViewModel]
    
    let numberOfRatings: Int
    let averageRating: Double
    
    init(_ feedback: [Feedback], showConfirmation: Bool) {
        self.showConfirmation = showConfirmation
        self.feedback = feedback.map(FeedbackViewModel.init)
        numberOfRatings = feedback.count
        if numberOfRatings > 0 {
            let totalRating = feedback.map { $0.rating }.reduce(0, +)
            averageRating = Double(totalRating * 100 / numberOfRatings) / 100 // Keep only two digits after the decimal point.
        } else {
            averageRating = 0
        }
    }
}
