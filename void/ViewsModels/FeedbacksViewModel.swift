
import Foundation

class FeedbacksViewModel: ObservableObject {
    private let persistence: PersistenceController = PersistenceController.shared
    
    func feedbacks(_ classroom: Classroom, from student: Student? = nil) -> [Feedback] {
        let feedbacks: NSSet? = student == nil ? classroom.feedbacks : student!.feedbacks
        
        return Array(feedbacks?.allObjects as? [Feedback] ?? []).sorted {
            $0.createdAt! > $1.createdAt!
        }
    }
}
