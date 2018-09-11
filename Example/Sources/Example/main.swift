import Foundation
import HeliumLogger
import Kitura
import KituraStencil

let persistence = Persistence()
let router = Router()

router.all("public", middleware: StaticFileServer())
router.setDefault(templateEngine: StencilTemplateEngine())

router.get("hello") {
    request, response, next in
    response.send("Hello")
    next()
}

router.get("feedback") {
    request, response, next in
    let feedback = persistence.getAllFeedback()
    let viewModel = FeedbackPageViewModel(feedback, showConfirmation: false)
    try response.render("feedback", with: viewModel)
    next()
}

router.post("feedback") {
    request, response, next in
    guard let form = try? request.read(as: FeedbackForm.self), form.isValid else {
        response.status(.badRequest)
        return next()
    }
    let newFeedback = Feedback(date: Date(), rating: form.rating, comment: form.comment)
    persistence.add(newFeedback)
    try response.render("feedback", with: FeedbackPageViewModel(
        persistence.getAllFeedback(),
        showConfirmation: true))
    next()
}

HeliumLogger.use()
Kitura.addHTTPServer(onPort: 8080, with: router)
Kitura.run()
