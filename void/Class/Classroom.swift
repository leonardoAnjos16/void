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
    var topics: [Topic] = []
    
    init(name: String, description: String, semester: String) {
        self.name = name
        self.description = description
        self.semester = semester
        self.code = "6X3DZ9"
    }
}
