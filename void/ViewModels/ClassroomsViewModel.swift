
import Foundation

class ClassroomsViewModel: ObservableObject {
    private let persistence: PersistenceController = PersistenceController.shared
    
    @Published var classrooms: [Classroom] = []
    
    init() {
        classrooms = persistence.fetchAll(sortDescriptors: [
            NSSortDescriptor(key: "order", ascending: true)
        ])
    }
    
    func newClassroom() -> Classroom {
        return persistence.new()
    }
    
    func updateClassroom(_ classroom: Classroom, name: String, desc: String,
                         semester: String, location: String) {
        classroom.name = name
        classroom.desc = desc
        classroom.semester = semester
        classroom.location = location
        
        if (classroom.code ?? "").isEmpty {
            classroom.code = String((0..<6).map({ _ in
                "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz".randomElement()!
            }))
            
            classrooms.insert(classroom, at: 0)
        }
        
        save()
    }
    
    func deleteClassrooms(at offsets: IndexSet) {
        persistence.delete(offsets.map({ classrooms.remove(at: $0) }))
        save()
    }
    
    func moveClassrooms(from source: IndexSet, to destination: Int) {
        classrooms.move(fromOffsets: source, toOffset: destination)
        save()
    }
    
    private func save() {
        classrooms.enumerated().forEach { (i, classroom) in
            classroom.order = Int16(i)
        }
        
        persistence.save()
    }
    
    func discard() {
        persistence.rollback()
    }
}
