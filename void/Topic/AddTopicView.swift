//
//  AddTopic.swift
//  void
//
//  Created by Leonardo dos Anjos Silva on 27/09/22.
//

import SwiftUI

struct AddTopicView: View {
    @EnvironmentObject var classroomViewModel: ClassroomViewModel
    @StateObject var topicViewModel = TopicViewModel()
    @Binding var isActive: Bool
    
    var body: some View {
        VStack {
            Text("Adicionar Tópico").bold()
            TextField("Nome", text: $topicViewModel.topic.name)
            DatePicker(selection: $topicViewModel.topic.from, displayedComponents: .date, label: { Text("Começa") }).id(topicViewModel.topic.from)
            DatePicker(selection: $topicViewModel.topic.to, displayedComponents: .date, label: { Text("Termina") }).id(topicViewModel.topic.to)
            Button("Adicionar") {
                classroomViewModel.addTopic(topic: topicViewModel.topic)
                isActive = false
            }
            Spacer()
        }.padding()
    }
}

struct AddTopic_Previews: PreviewProvider {
    static var previews: some View {
//        AddTopicView(isActive: true)
        Text("Something")
    }
}
