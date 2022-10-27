
import SwiftUI

struct StudentClassroomView: View {
    @EnvironmentObject var viewModel: StudentClassroomsViewModel
    @EnvironmentObject var studentsViewModel: StudentsViewModel
    @EnvironmentObject var topicsViewModel: TopicsViewModel
    @EnvironmentObject var feedbacksViewModel: FeedbacksViewModel
    @EnvironmentObject var studentClassroom: StudentClassroom
 
    @State private var feedbackMessage: String = ""
    
    private var feedbacks: [Feedback] {
        feedbacksViewModel.feedbacks(from: studentClassroom.student)
    }
    
    var body: some View {
        List {
            Section("Self-Assessment") {
                ForEach(topicsViewModel.topics) { topic in
                    TopicSelfAssessment(
                        studentTopic: studentsViewModel.studentTopic(from: studentClassroom, topic)
                    )
                }
                
                if topicsViewModel.topics.isEmpty {
                    Text("No Topics")
                }
            }
            
            Section("New Feedback") {
                TextField("Write you feedback here...", text: $feedbackMessage, axis: .vertical)
                
                Button("Send Feedback") {
                    feedbacksViewModel.addFeedback(from: studentClassroom, message: feedbackMessage)
                    feedbackMessage = ""
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
        .navigationTitle(studentClassroom.classroom?.name ?? "")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct TopicSelfAssessment: View {
    @EnvironmentObject var studentsViewModel: StudentsViewModel
    
    @StateObject var studentTopic: StudentTopic
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(studentTopic.topic?.title ?? "")
            Text("\(studentTopic.topic?.from) to \(studentTopic.topic?.to)")
                .font(.footnote)
            
            HStack {
                Slider(value: $studentTopic.progress, in: 0...100, step: 5) { isEditing in
                    if !isEditing {
                        studentsViewModel.save()
                    }
                }
                
                Text("\(studentTopic.progress, specifier: "%3.0f")%")
                    .font(.callout)
                    .monospaced()
            }
        }
    }
}
