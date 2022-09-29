//
//  ClassModel.swift
//  void
//
//  Created by Leonardo dos Anjos Silva on 22/09/22.
//

import Foundation

class Classroom {
    var name: String
    var description: String
    var semester: String
    var code: String
    var topics: [Topic] = [
        Topic(name: "Variáveis", from: Date.now, to: Date.now, progress: 0.98),
        Topic(name: "Condicionais e Lógica", from: Date.now, to: Date.now, progress: 0.72),
        Topic(name: "Loops", from: Date.now, to: Date.now, progress: 0.48)
    ]
    var students: [Student] = [
        Student(name: "Kauê Ferreira Alves"),
        Student(name: "Yasmin Santos Araújo"),
        Student(name: "Gabrielle Souza Dias"),
        Student(name: "Nicolas Lima Fernandes")
    ]
    
    init(name: String, description: String, semester: String) {
        self.name = name
        self.description = description
        self.semester = semester
        self.code = "6X3DZ9"
    }
}
