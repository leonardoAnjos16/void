//
//  AddTopic.swift
//  void
//
//  Created by Leonardo dos Anjos Silva on 27/09/22.
//

import SwiftUI

struct AddTopic: View {
    @StateObject var topicViewModel = TopicViewModel()
    
    var body: some View {
        VStack {
            TextField("Nome", text: $topicViewModel.topic.name)
            DatePicker(selection: $topicViewModel.topic.from, label: { Text("Começa") })
            DatePicker(selection: $topicViewModel.topic.to, label: { Text("Termina") })
        }
    }
}

struct AddTopic_Previews: PreviewProvider {
    static var previews: some View {
        AddTopic()
    }
}
