//
//  ClassViewModel.swift
//  void
//
//  Created by Leonardo dos Anjos Silva on 22/09/22.
//

import Foundation

class ClassViewModel: ObservableObject {
    @Published var classroom = Classroom(name: "Desenvolvimento iOS", description: "Programação com Swift", semester: "2022.1")
    
    func addTopic(name: String, from: Date, to: Date) {
        classroom.topics.append(Topic(name: name, from: from, to: to))
    }
}
