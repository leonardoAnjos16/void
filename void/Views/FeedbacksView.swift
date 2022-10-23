
import SwiftUI

struct FeedbacksView: View {
    @EnvironmentObject var classroom: Classroom
    @Environment(\.dismiss) private var dismiss
    
    @StateObject var feedbacksViewModel = FeedbacksViewModel()
    
    var student: Student?
    private var feedbacks: [Feedback] { feedbacksViewModel.feedbacks(classroom, from: student) }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(feedbacks) { feedback in
                    FeedbackCard(feedback: feedback)
                }
                
                if feedbacks.isEmpty {
                    Text("No Feedbacks")
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            .navigationTitle("Feedbacks")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Label("Go to Classrooms", systemImage: "chevron.backward")
                            .fontWeight(.semibold)
                            .labelStyle(.iconOnly)
                    }
                }
            }
            .navigationBarHidden(student != nil)
        }
    }
}

struct FeedbackCard: View {
    @StateObject var studentsViewModel = StudentsViewModel()
    
    var feedback: Feedback
    var showStudent = true
    
    var body: some View {
        HStack {
            if showStudent {
                Image(studentsViewModel.plant(from: feedback.student!))
                    .padding(.trailing, 8)
            }
            
            VStack(alignment: .leading) {
                HStack {
                    if showStudent {
                        Text(feedback.student!.name!)
                            .fontWeight(.semibold)
                        
                        Spacer()
                    }
                    
                    Text(timePast(date: feedback.createdAt!))
                        .foregroundColor(Color.secondary)
                        .fixedSize()
                }
                .lineLimit(1)
                .padding(.bottom, 1)
                
                Text(feedback.message!)
                    .font(.subheadline)
            }
        }
    }
}
