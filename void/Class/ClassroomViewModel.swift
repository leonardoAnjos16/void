//
//  ClassViewModel.swift
//  void
//
//  Created by Leonardo dos Anjos Silva on 22/09/22.
//

import Foundation

class ClassroomViewModel: ObservableObject {
    @Published var classroom = Classroom(name: "Desenvolvimento iOS", description: "Programação com Swift", semester: "2022.1")
    
    func addTopic(topic: Topic) {
        classroom.topics.append(topic)
        objectWillChange.send()
    }
}
