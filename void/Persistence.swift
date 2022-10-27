
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
        
        func newStudent(_ name: String, topicsProgress: [Int]) {
            student = new()
            student!.name = name
            
            studentClassroom = new()
            studentClassroom!.classroom = classroom!
            studentClassroom!.student = student!
            studentClassroom!.order = 0
            
            (classroom!.topics as? Set<Topic> ?? [])
                .sorted(by: {$0.from! < $1.from!})
                .enumerated().forEach { (i, topic) in
                    let studentTopic: StudentTopic = new()
                    
                    studentTopic.studentClassroom = studentClassroom
                    studentTopic.topic = topic
                    studentTopic.progress = Float(topicsProgress[i])
                }
        }
        
        func newFeedback(message: String, day: Int = Int.random(in: -7...7), date: Date? = nil) {
            feedback = new()
            feedback!.createdAt = (date != nil ? date
                                   : Date().advanced(by: TimeInterval(day * 86400) + TimeInterval.random(in: 0...86400)))
            feedback!.message = String(localized: String.LocalizationValue(message))
            feedback!.classroom = classroom!
            feedback!.studentClassroom = studentClassroom!
        }
        
        
        newClassroom(name: "iOS Development", desc: "Programming in Swift", semester: "2022.1",
                     location: "Apple Developer Academy", code: "xzT3G3")
        newTopic(title: "Variables", fromDay: -18, toDay: -11)
        newTopic(title: "Condionals and Logic", fromDay: -12, toDay: -5)
        newTopic(title: "Loops", fromDay: -4, toDay: 3)
        
        newStudent("Brenda Alves", topicsProgress: [90, 75, 0])
        newStudent("Nicolas Lima Fernandes", topicsProgress: [85, 30, 0])
        newStudent("Yasmin Santos Araújo", topicsProgress: [100, 90, 75])
        
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
