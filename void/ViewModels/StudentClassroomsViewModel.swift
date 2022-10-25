
import Foundation

class StudentClassroomsViewModel: ObservableObject {
    private let persistence: PersistenceController = PersistenceController.shared
    
    @Published private var student: Student
    
    init(_ student: Student) {
        self.student = student
    }
    
    var studentClassrooms: [StudentClassroom] {
        (student.classrooms as? Set<StudentClassroom> ?? []).sorted { $0.order < $1.order }
    }
    
    func deleteClassrooms(at offsets: IndexSet) {
        persistence.delete(offsets.map({ studentClassrooms[$0] }))
        save()
    }
    
    func moveClassrooms(from source: IndexSet, to destination: Int) {
        var studentClassrooms = self.studentClassrooms
        
        studentClassrooms.move(fromOffsets: source, toOffset: destination)
        studentClassrooms.enumerated().forEach { (i, studentClassroom) in
            studentClassroom.order = Int16(i)
        }
        
        persistence.save()
    }
    
    func addClassroom(code: String) {
        let classroom: Classroom? = persistence.fetchAll(sortDescriptors: [
            NSSortDescriptor(key: "order", ascending: true)
        ]).first { $0.code == code }
        
        if classroom != nil {
            let studentClassroom: StudentClassroom = persistence.new()
            
            studentClassroom.student = student
            studentClassroom.classroom = classroom!
            
            save()
        }
    }
    
    private func save() {
        moveClassrooms(from: [0], to: 0)
    }
}
