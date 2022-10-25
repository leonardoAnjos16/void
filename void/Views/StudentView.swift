
import SwiftUI

struct StudentView: View {
    @EnvironmentObject var viewModel: StudentsViewModel
    @EnvironmentObject var topicsViewModel: TopicsViewModel
    @EnvironmentObject var feedbacksViewModel: FeedbacksViewModel
    @EnvironmentObject var studentClassroom: StudentClassroom
    
    private var topics: [Topic] { topicsViewModel.topics }
    private var feedbacks: [Feedback] {
        feedbacksViewModel.feedbacks(from: studentClassroom.student)
    }
    
    var body: some View {
        List {
            Section("Self-Assessment") {
                ForEach(topics) { topic in
                    TopicCard(
                        topic: topic,
                        progress: viewModel.studentTopic(from: studentClassroom, topic).progress
                    )
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
        .navigationTitle(studentClassroom.student?.name ?? "")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct StudentCard: View {
    @EnvironmentObject var studentsViewModel: StudentsViewModel
    
    var studentClassroom: StudentClassroom
    
    var body: some View {
        NavigationLink(destination: {
            StudentView()
                .environmentObject(studentClassroom)
        }) {
            HStack {
                Image(studentsViewModel.plant(from: studentClassroom))
                    .padding(.trailing, 8)
                
                Text(studentClassroom.student?.name ?? "")
            }
        }
    }
}
