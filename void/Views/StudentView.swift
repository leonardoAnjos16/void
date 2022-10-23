
import SwiftUI

struct StudentView: View {
    @EnvironmentObject var studentsViewModel: StudentsViewModel
    @EnvironmentObject var topicsViewModel: TopicsViewModel
    @StateObject var feedbacksViewModel = FeedbacksViewModel()
    
    var student: Student
    
    private var topics: [Topic] { topicsViewModel.topics(from: student.classroom!) }
    private var feedbacks: [Feedback] { feedbacksViewModel.feedbacks(student.classroom!, from: student) }
    
    var body: some View {
        List {
            Section("Self-Assessment") {
                ForEach(topics) { topic in
                    TopicCard(topic: topic,
                              progress: studentsViewModel.progress(from: student, topic))
                }
                
                if topics.isEmpty {
                    Text("No Topics")
                }
            }
            
            Section("Feedbacks") {
                ForEach(feedbacks) { feedback in
                    FeedbackCard(feedback: feedback, showStudent: false)
                }
                
                if feedbacks.isEmpty {
                    Text("No Feedbacks")
                }
            }
        }
        .listStyle(.insetGrouped)
        .navigationTitle(student.name!)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct StudentCard: View {
    @EnvironmentObject var studentsViewModel: StudentsViewModel
    var student: Student
    
    var body: some View {
        NavigationLink(destination: StudentView(student: student)) {
            HStack {
                Image(studentsViewModel.plant(from: student))
                    .padding(.trailing, 8)
                
                Text(student.name!)
            }
        }
    }
}
