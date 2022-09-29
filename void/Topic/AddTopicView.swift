//
//  AddTopic.swift
//  void
//
//  Created by Leonardo dos Anjos Silva on 27/09/22.
//

import SwiftUI

struct AddTopicView: View {
    @StateObject var topicViewModel = TopicViewModel()
    
    var body: some View {
        VStack {
            TextField("Nome", text: $topicViewModel.topic.name)
            DatePicker(selection: $topicViewModel.topic.from, displayedComponents: .date, label: { Text("Começa") })
            DatePicker(selection: $topicViewModel.topic.to, displayedComponents: .date, label: { Text("Termina") })
            Spacer()
        }.padding()
    }
}

struct AddTopic_Previews: PreviewProvider {
    static var previews: some View {
        AddTopicView()
    }
}
