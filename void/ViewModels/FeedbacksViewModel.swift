
import Foundation

class FeedbacksViewModel: ObservableObject {
    private let persistence: PersistenceController = PersistenceController.shared
    
    @Published private var classroom: Classroom
    
    init(_ classroom: Classroom) {
        self.classroom = classroom
    }
    
    var feedbacks: [Feedback] {
        (classroom.feedbacks as? Set<Feedback> ?? []).sorted {
            $0.createdAt! > $1.createdAt!
        }
    }
    
    func feedbacks(from student: Student?) -> [Feedback] {
        return Array((student?.classrooms as? Set<StudentClassroom> ?? []).first { $0.classroom?.objectID == classroom.objectID
        }?.feedbacks as? Set<Feedback> ?? []).sorted {
            $0.createdAt! > $1.createdAt!
        }
    }
    
    func addFeedback(from studentClassroom: StudentClassroom, message: String) {
        let feedback: Feedback = persistence.new()
        
        feedback.message = message
        feedback.studentClassroom = studentClassroom
        feedback.classroom = classroom
        feedback.createdAt = Date()
        
        persistence.save()
    }
}
