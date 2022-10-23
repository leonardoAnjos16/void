
import SwiftUI

struct TopicCard: View {
    @EnvironmentObject var topicsViewModel: TopicsViewModel
    var topic: Topic
    var progress: Int16?
    
    private var _progress: Float {
        progress != nil ? Float(progress!) : topicsViewModel.averageProgress(from: topic)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(topic.title!)
            
            Text("\(dateToString(topic.from)) to \(dateToString(topic.to))")
                .font(.footnote)
            
            HStack {
                ProgressView(value: _progress, total: 100)
                Text("\(_progress, specifier: "%.0f")%")
            }
        }
    }
}

struct NewTopicView: View {
    @EnvironmentObject var topicsViewModel: TopicsViewModel
    @EnvironmentObject var classroom: Classroom
    @Environment(\.dismiss) private var dismiss
    
    @State private var title = ""
    @State private var from = Date()
    @State private var to = Date()
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    TextField("Title", text: $title)
                }
                
                Section {
                    DatePicker("Starts", selection: $from, displayedComponents: [.date])
                        .datePickerStyle(.compact)
                    
                    DatePicker("Ends", selection: $to, in: from..., displayedComponents: [.date])
                        .datePickerStyle(.compact)
                }
            }
            .navigationTitle("New Topic")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        topicsViewModel.addTopic(classroom, title: title, from: from, to: to)
                        dismiss()
                    }
                    .disabled(title.isEmpty)
                }
            }
        }
    }
}
