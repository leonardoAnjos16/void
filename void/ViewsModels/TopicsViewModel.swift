
import Foundation

class TopicsViewModel: ObservableObject {
    private let persistence: PersistenceController = PersistenceController.shared
    
    func addTopic(_ classroom: Classroom, title: String, from: Date, to: Date) {
        let topic: Topic = persistence.new()
        
        topic.title = title
        topic.from = from.onlyDate
        topic.to = to.onlyDate
        topic.classroom = classroom
        
        persistence.refresh()
    }
    
    func delete(topics: [Topic]) {
        persistence.delete(topics)
        persistence.refresh()
    }
    
    func topics(from classroom: Classroom) -> [Topic] {
        return Array(classroom.topics as? Set<Topic> ?? []).sorted {
            if $0.from! != $1.from! {
                return $0.from! < $1.from!
            }
            
            if $0.to! != $1.to! {
                return $0.to! < $1.to!
            }
            
            return $0.title! < $1.title!
        }
    }
    
    func averageProgress(from topic: Topic) -> Float {
        let studentsProgress = topic.studentsTopics?.map({
            ($0 as! StudentTopic).progress
        }) ?? []
        
        if studentsProgress.count != 0 {
            return (Float(studentsProgress.reduce(Int16(0), +)) /
                    Float(studentsProgress.count))
        } else {
            return 0
        }
    }
}
