
import Foundation
import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    private let mainViewContext: NSManagedObjectContext
    
    init() {
        let container = NSPersistentContainer(name: "void")
        let inMemory: Bool = {
#if DEBUG
            return true
#else
            return false
#endif
        }()
        
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let nsError = error as NSError? {
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        })
        
        mainViewContext = container.viewContext
        mainViewContext.automaticallyMergesChangesFromParent = true
        
        let firstRunKey = "\(container.name)_firstRun"
        UserDefaults.standard.register(defaults: [firstRunKey: true])
        
        if inMemory || UserDefaults.standard.bool(forKey: firstRunKey) {
            prePopulate()
            
            if !inMemory {
                UserDefaults.standard.set(false, forKey: firstRunKey)
            }
        }
    }
    
    private func prePopulate() {
        var classrooms: [Classroom] = []
        var classroom: Classroom?
        var topic: Topic?
        var student: Student?
        var studentClassroom: StudentClassroom?
        var feedback: Feedback?
        
        func newClassroom(name: String, desc: String, semester: String, location: String, code: String) {
            classroom = new()
            classroom!.name = String(localized: String.LocalizationValue(name))
            classroom!.desc = String(localized: String.LocalizationValue(desc))
            classroom!.semester = semester
            classroom!.location = location
            classroom!.code = code
            classroom!.order = Int16(classrooms.count)
            
            classrooms.append(classroom!)
        }
        
        func newTopic(title: String, fromDay: Int, toDay: Int) {
            topic = new()
            topic!.title = String(localized: String.LocalizationValue(title))
            topic!.from = Date().advanced(by: TimeInterval(fromDay /* days */ * 86400)).onlyDate
            topic!.to = Date().advanced(by: TimeInterval(toDay * 86400)).onlyDate
            topic!.classroom = classroom!
        }
        
        func newStudent(name: String) {
            student = new()
            student!.name = name
            
            studentClassroom = new()
            studentClassroom!.classroom = classroom!
            studentClassroom!.student = student!
            studentClassroom!.order = 0
        }
        
        func newFeedback(message: String) {
            feedback = new()
            feedback!.createdAt = Date().advanced(by: -7 * 86400 + TimeInterval.random(in: 0...86400))
            feedback!.message = String(localized: String.LocalizationValue(message))
            feedback!.classroom = classroom!
            feedback!.studentClassroom = studentClassroom!
        }
        
        
        newClassroom(name: "iOS Development", desc: "Programming in Swift",
                     semester: "2022.1", location: "Apple Developer Academy",
                     code: "xzT3G3")
        newTopic(title: "Variables", fromDay: -10, toDay: -3)
        newTopic(title: "Condionals and Logic", fromDay: -2, toDay: 5)
        newTopic(title: "Loops", fromDay: 6, toDay: 13)
        
        newStudent(name: "Gabrielle Souza Dias")
        
        newStudent(name: "Kauê Ferreira Alves")
        newFeedback(message: "I felt a bit lost. I think it would be better if there were more examples in class")
        
        newStudent(name: "Yasmin Santos Araújo")
        newStudent(name: "Nicolas Lima Fernandes")
        
        newClassroom(name: "Design", desc: "", semester: "2022.1",
                     location: "Apple Developer Academy", code: "FOAEQo")
        newClassroom(name: "Innovation", desc: "", semester: "2022.1",
                     location: "Apple Developer Academy", code: "eVePGg")
        
        classrooms.forEach { classroom in
            (classroom.students as? Set<StudentClassroom> ?? []).forEach { studentClassroom in
                (classroom.topics as? Set<Topic> ?? []).forEach { topic in
                    let studentTopic: StudentTopic = new()
                    
                    studentTopic.studentClassroom = studentClassroom
                    studentTopic.topic = topic
                    studentTopic.progress = Float(Int16.random(in: 0...100))
                }
            }
        }
        
        save()
    }
    
    func fetchAll<EntityType: NSManagedObject>(sortDescriptors: [NSSortDescriptor]) -> [EntityType] {
        do {
            let fetchRequest = EntityType.fetchRequest() as! NSFetchRequest<EntityType>
            fetchRequest.sortDescriptors = sortDescriptors
            
            let fetchedResultsController = NSFetchedResultsController(
                fetchRequest: fetchRequest,
                managedObjectContext: mainViewContext,
                sectionNameKeyPath: nil,
                cacheName: "\(EntityType.self)"
            )
            
            try fetchedResultsController.performFetch()
            
            return fetchedResultsController.fetchedObjects ?? []
        } catch {
            if let nsError = error as NSError? {
                fatalError("Unresolved error while saving: \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    func new<EntityType: NSManagedObject>() -> EntityType {
        return EntityType(context: mainViewContext)
    }
    
    func delete<EntityType: NSManagedObject>(_ entities: [EntityType]) {
        entities.forEach(mainViewContext.delete)
    }
    
    func refresh() {
        mainViewContext.refreshAllObjects()
    }
    
    func save() {
        do {
            if mainViewContext.hasChanges {
                try mainViewContext.save()
                
                refresh()
            }
        } catch {
            if let nsError = error as NSError? {
                fatalError("Unresolved error while saving: \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    func rollback() {
        mainViewContext.rollback()
        refresh()
    }
}
