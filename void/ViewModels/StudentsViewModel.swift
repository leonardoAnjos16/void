
import Foundation

class StudentsViewModel: ObservableObject {
    private let persistence: PersistenceController = PersistenceController.shared
    
    @Published private var classroom: Classroom
    
    init(_ classroom: Classroom) {
        self.classroom = classroom
    }
    
    var studentClassrooms: [StudentClassroom] {
        (classroom.students as? Set<StudentClassroom> ?? [])
            .sorted { $0.student!.name! < $1.student!.name! }
    }
    
    func plant(from studentClassroom: StudentClassroom?) -> String {
        var imageSize = "Big"
        
        if studentClassroom != nil {
            let studentScore = score(from: studentClassroom!)
            
            if studentScore < 0.25 {
                imageSize = "VerySmall"
            } else if studentScore < 0.5 {
                imageSize = "Small"
            } else if studentScore < 0.75 {
                imageSize = "Medium"
            }
        }
        
        return "Plant\(imageSize)"
    }
    
    func studentClassroom(from student: Student) -> StudentClassroom? {
        return studentClassrooms.first { $0.classroom?.objectID == classroom.objectID }
    }
    
    func score(from studentClassroom: StudentClassroom) -> Double {
        var score = 0.0, totalWeight = 0.0
        
        (studentClassroom.studentTopics as? Set<StudentTopic> ?? []).forEach { studentTopic in
            // FIXME: -
            let a = Date.now.timeIntervalSince(studentTopic.topic!.from!)
            let b = studentTopic.topic!.to!.timeIntervalSince(studentTopic.topic!.from!)
            
            let weight = a / b
            
            score += Double(studentTopic.progress) * weight
            totalWeight += weight
        }
        
        return score / totalWeight
    }
    
    func studentTopic(from studentClassroom: StudentClassroom, _ topic: Topic) -> StudentTopic {
        if let studentTopic = (studentClassroom.studentTopics as? Set<StudentTopic> ?? []).first(
            where: { $0.topic?.objectID == topic.objectID }
        ) {
            return studentTopic
        } else {
            let studentTopic: StudentTopic = persistence.new()
            
            studentTopic.studentClassroom = studentClassroom
            studentTopic.topic = topic
            studentTopic.progress = 0
            
            persistence.refresh()
            
            return studentTopic
        }
    }
    
    func save() {
        persistence.save()
    }
}
