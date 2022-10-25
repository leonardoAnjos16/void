
import SwiftUI

struct TopicCard: View {
    @EnvironmentObject var viewModel: TopicsViewModel
    
    var topic: Topic
    var progress: Float?
    
    private var topicProgress: Float { progress ?? viewModel.averageProgress(from: topic) }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(topic.title ?? "")
            Text("\(topic.from) to \(topic.to)")
                .font(.footnote)
            
            HStack {
                ProgressView(value: topicProgress, total: 100)
                Text("\(topicProgress, specifier: "%3.0f")%")
                    .font(.callout)
                    .monospaced()
            }
        }
    }
}

struct NewTopicView: View {
    @EnvironmentObject var viewModel: TopicsViewModel
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
                        viewModel.addTopic(title: title, from: from, to: to)
                        dismiss()
                    }
                    .disabled(title.isEmpty)
                }
            }
        }
    }
}
