
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
        var totalScore = 0.0, totalWeight = 0.0
        
        (studentClassroom.studentTopics as? Set<StudentTopic> ?? []).forEach { studentTopic in
            var topicScore = 0.0, topicWeight = 1.0
            
            let topicProgress = Double(studentTopic.progress / 100)
            let topicDuration = studentTopic.topic!.to!.timeIntervalSince(studentTopic.topic!.from!)
            let timeSinceFrom = Date.now.timeIntervalSince(studentTopic.topic!.from!)
            let timeSinceTo = Date.now.timeIntervalSince(studentTopic.topic!.to!)
            
            if timeSinceFrom < 0 {
                if topicProgress > 0 {
                    topicScore = min(topicProgress * (-1.5 / timeSinceFrom / topicDuration), 3.0)
                } else {
                    topicWeight = 0.0
                }
            } else if timeSinceTo < 0 {
                topicScore = min(topicProgress * (1 / (timeSinceFrom / topicDuration)), 2.0)
            } else {
                topicScore = topicProgress - (0.5 * (1.0 - topicProgress) * min(timeSinceTo / topicDuration, 1.0))
            }
            
            totalScore += topicScore
            totalWeight += topicWeight
        }
        
        return min(totalScore / totalWeight, 1.0)
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
