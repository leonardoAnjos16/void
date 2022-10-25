
import SwiftUI

struct FeedbacksView: View {
    @EnvironmentObject var feedbacksViewModel: FeedbacksViewModel
    @Environment(\.dismiss) private var dismiss
    
    private var feedbacks: [Feedback] { feedbacksViewModel.feedbacks }
    
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
        }
    }
}

struct FeedbackCard: View {
    @EnvironmentObject var studentsViewModel: StudentsViewModel
    
    var feedback: Feedback
    var showStudent = true
    
    var body: some View {
        HStack {
            if showStudent {
                Image(studentsViewModel.plant(from: feedback.studentClassroom))
                    .padding(.trailing, 8)
            }
            
            VStack(alignment: .leading) {
                HStack {
                    if showStudent {
                        Text(feedback.studentClassroom?.student?.name ?? "")
                            .fontWeight(.semibold)
                        Spacer()
                    }
                    
                    Text("\(feedback.createdAt, timeStyle: .short)")
                        .foregroundColor(Color.secondary)
                }
                .font(.footnote)
                .lineLimit(1)
                .padding(.bottom, 1)
                
                Text(feedback.message ?? "")
                    .font(.subheadline)
            }
        }
    }
}
