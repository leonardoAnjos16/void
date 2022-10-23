
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
            
            UserDefaults.standard.set(false, forKey: firstRunKey)
        }
    }
    
    private func prePopulate() {
        var classrooms: [Classroom] = []
        var classroom: Classroom
        var topic: Topic
        var student: Student
        var feedback: Feedback
        
        classroom = new()
        classroom.name = String(localized: "iOS Development")
        classroom.desc = String(localized: "Programming in Swift")
        classroom.semester = "2022.1"
        classroom.location = "Apple Developer Academy"
        classroom.code = "xzT3G3"
        classroom.order = 0
        classrooms.append(classroom)
        
        topic = new()
        topic.title = String(localized: "Variables")
        topic.from = Date().advanced(by: -10 /* days */ * 86400).onlyDate
        topic.to = Date().advanced(by: -3 * 86400).onlyDate
        topic.classroom = classroom
        
        topic = new()
        topic.title = String(localized: "Condionals and Logic")
        topic.from = Date().advanced(by: -2 * 86400).onlyDate
        topic.to = Date().advanced(by: 5 * 86400).onlyDate
        topic.classroom = classroom
        
        topic = new()
        topic.title = String(localized: "Loops")
        topic.from = Date().advanced(by: 6 * 86400).onlyDate
        topic.to = Date().advanced(by: 13 * 86400).onlyDate
        topic.classroom = classroom
        
        student = new()
        student.name = "Gabrielle Souza Dias"
        student.classroom = classroom
        
        student = new()
        student.name = "Kauê Ferreira Alves"
        student.classroom = classroom
        
        feedback = new()
        feedback.createdAt = Date().advanced(by: -7 * 86400)
        feedback.message = String(localized: "I felt a bit lost. I think it would be better if there were more examples in class")
        feedback.classroom = classroom
        feedback.student = student
        
        student = new()
        student.name = "Yasmin Santos Araújo"
        student.classroom = classroom
        
        student = new()
        student.name = "Nicolas Lima Fernandes"
        student.classroom = classroom
        
        classroom = new()
        classroom.name = String(localized: "Design")
        classroom.desc = ""
        classroom.semester = "2022.1"
        classroom.location = "Apple Developer Academy"
        classroom.code = "FOAEQo"
        classroom.order = 1
        classrooms.append(classroom)
        
        student = new()
        student.name = "Gabrielle Souza Dias"
        student.classroom = classroom
        
        classroom = new()
        classroom.name = String(localized: "Innovation")
        classroom.desc = ""
        classroom.semester = "2022.1"
        classroom.location = "Apple Developer Academy"
        classroom.code = "eVePGg"
        classroom.order = 2
        classrooms.append(classroom)
        
        classrooms.forEach { classroom in
            classroom.students?.compactMap({ $0 as? Student }).forEach { student in
                classroom.topics?.compactMap({ $0 as? Topic }).forEach { topic in
                    let studentTopic: StudentTopic = new()
                    
                    studentTopic.student = student
                    studentTopic.topic = topic
                    studentTopic.progress = Int16.random(in: 0...100)
                    
                    topic.addToStudentsTopics(studentTopic)
                    student.addToTopics(studentTopic)
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
            }
        } catch {
            if let nsError = error as NSError? {
                fatalError("Unresolved error while saving: \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    func rollback() {
        mainViewContext.rollback()
        mainViewContext.refreshAllObjects()
    }
}
