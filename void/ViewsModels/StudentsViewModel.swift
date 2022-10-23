
import Foundation

class StudentsViewModel: ObservableObject {
    private let persistence: PersistenceController = PersistenceController.shared
    
    func students(from classroom: Classroom) -> [Student] {
        return Array(classroom.students as? Set<Student> ?? []).sorted {
            return $0.name! < $1.name!
        }
    }
    
    func plant(from student: Student) -> String {
        var imageSize = "Big"
        let studentScore = score(from: student)
        
        if studentScore < 0.25 {
            imageSize = "VerySmall"
        } else if studentScore < 0.5 {
            imageSize = "Small"
        } else if studentScore < 0.75 {
            imageSize = "Medium"
        }
        
        return "Plant\(imageSize)"
    }
    
    func score(from student: Student) -> Double {
        var score = 0.0, totalWeight = 0.0
        
        Array(student.topics?.allObjects as? [StudentTopic] ?? [])
            .forEach { studentTopic in
                // FIXME: -
                let a = Date.now.timeIntervalSince(studentTopic.topic!.from!)
                let b = studentTopic.topic!.to!.timeIntervalSince(studentTopic.topic!.from!)
                
                let weight = a / b
                
                score += Double(studentTopic.progress) * weight
                totalWeight += weight
            }
        
        return score / totalWeight
    }
    
    func progress(from student: Student, _ topic: Topic) -> Int16 {
        if let studentTopic = student.topics?.compactMap({ $0 as? StudentTopic }).first(where: {
            $0.topic?.objectID == topic.objectID
        }) {
            return studentTopic.progress
        }
        
        return 0
    }
}
