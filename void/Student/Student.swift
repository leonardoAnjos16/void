//
//  Student.swift
//  void
//
//  Created by Leonardo dos Anjos Silva on 28/09/22.
//

import Foundation

class Student: Identifiable {
    var id = UUID()
    var name: String
    var topics: [Topic] = [
        Topic(name: "Variáveis", from: Date.now, to: Date.now, progress: 1.0),
        Topic(name: "Condicionais e Lógica", from: Date.now, to: Date.now, progress: 0.22),
        Topic(name: "Loops", from: Date.now, to: Date.now, progress: 0.02),
//        Topic(name: "Funções", from: Date.now, to: Date.now, progress: 0.0),
    ]
    
    init(name: String) {
        self.name = name
    }
}
