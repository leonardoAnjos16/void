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
    
    init(name: String) {
        self.name = name
    }
}
